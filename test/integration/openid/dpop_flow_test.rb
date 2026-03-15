# frozen_string_literal: true

require_relative '../../test_helper'
require_relative 'openid_helper'

# =============================================================================
# OIDC DPoP Flow
# DPoP + scope=openid — verifies that the server correctly issues both a
# DPoP-bound access_token and an id_token when the two are combined.
# DPoP binds the access_token to a key; the id_token is unaffected by DPoP.
# =============================================================================

class OidcDpopFlowTest < Minitest::Test
  include IdpHelper
  include SdkHelper
  include OidcHelper
  include DpopHelper

  def setup
    service = idp_create_oidc_service(
      'tokenEndpoint' => DpopHelper::TOKEN_ENDPOINT
    )

    @service_api_key = service['apiKey']
    @service_id      = @service_api_key.to_s
    @sdk             = create_sdk_client(ORG_TOKEN)
    @client          = create_test_client(@sdk, @service_id)
    @client_id       = @client.client_id.to_s
    @client_secret   = @client.client_secret
  end

  def teardown
    idp_delete_service(@service_api_key) if @service_api_key
  end

  def test_dpop_oidc_flow
    key              = generate_ec_key
    nonce            = SecureRandom.hex(16)
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Step 1: Authorization request with scope=openid and nonce (no DPoP at auth endpoint)
    auth_resp = @sdk.authorization.process_request(
      service_id:            @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: "response_type=code&client_id=#{@client_id}" \
                    "&redirect_uri=#{encoded_redirect}" \
                    "&scope=openid&nonce=#{nonce}&state=#{STATE}"
      )
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION, got #{auth_resp.action}"
    refute_nil auth_resp.ticket

    # Step 2: Authorization issue
    issue_resp = @sdk.authorization.issue_response(
      service_id:                  @service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket:  auth_resp.ticket,
        subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize,
      "Expected LOCATION, got #{issue_resp.action}"
    refute_nil issue_resp.authorization_code

    # Step 3: Token request with DPoP proof
    token_resp = @sdk.tokens.process_request(
      service_id:    @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    "grant_type=authorization_code" \
                       "&code=#{issue_resp.authorization_code}" \
                       "&redirect_uri=#{encoded_redirect}",
        client_id:     @client_id,
        client_secret: @client_secret,
        dpop:          dpop_proof(key, 'POST', TOKEN_ENDPOINT),
        htm:           'POST',
        htu:           TOKEN_ENDPOINT
      )
    ).token_response

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"
    refute_nil token_resp.access_token

    id_token = token_resp.id_token.to_s
    refute_empty id_token, 'id_token must be present for openid scope'

    # Step 4: Validate ID token payload claims
    assert_oidc_claims(
      decode_jwt_payload(id_token),
      expected_sub:       SUBJECT,
      expected_nonce:     nonce,
      expected_client_id: @client_id
    )
  end
end

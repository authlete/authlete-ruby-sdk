# frozen_string_literal: true

require_relative '../test_helper'
require_relative 'openid_helper'

# =============================================================================
# OIDC DPoP Flow
# DPoP + scope=openid — verifies that the server correctly issues both a
# DPoP-bound access_token and an id_token when the two are combined.
# DPoP binds the access_token to a key; the id_token is unaffected by DPoP.
# =============================================================================

class OidcDpopFlowTest < Minitest::Test
  include SdkHelper
  include OidcHelper
  include DpopHelper

  def setup
    @service_id    = SERVICE_ID
    @mgmt_authlete_client      = create_sdk_client(MGMT_TOKEN)
    @authlete_client           = create_sdk_client(SERVICE_TOKEN)
    setup_oidc_service(@mgmt_authlete_client, @service_id, token_endpoint: TOKEN_ENDPOINT)
    @client        = create_test_client(@mgmt_authlete_client, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @mgmt_authlete_client.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
  end

  def test_dpop_oidc_flow
    key              = generate_ec_key
    nonce            = SecureRandom.hex(16)
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Step 1: Authorization request with scope=openid and nonce (no DPoP at auth endpoint)
    auth_resp = @authlete_client.authorization.process_request(
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
    issue_resp = @authlete_client.authorization.issue_response(
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
    token_resp = @authlete_client.tokens.process_request(
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

# frozen_string_literal: true

require_relative '../test_helper'
require_relative 'openid_helper'

# =============================================================================
# OIDC Authorization Code Flow
# Based on https://www.authlete.com/developers/tutorial/oidc/
# =============================================================================

class OidcAuthGrantFlowTest < Minitest::Test
  include SdkHelper
  include OidcHelper

  def setup
    @service_id    = SERVICE_ID
    @mgmt_sdk      = create_sdk_client(MGMT_TOKEN)
    @sdk           = create_sdk_client(SERVICE_TOKEN)
    setup_oidc_service(@mgmt_sdk, @service_id)
    @client        = create_test_client(@mgmt_sdk, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @mgmt_sdk.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
  end

  def test_oidc_basic_flow
    nonce            = SecureRandom.hex(16)
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Step 1: Authorization request with scope=openid and nonce
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
    refute_nil auth_resp.ticket, 'ticket must be present'

    # Step 2: Authorization issue (simulate user consent)
    issue_resp = @sdk.authorization.issue_response(
      service_id:                  @service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket:  auth_resp.ticket,
        subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize,
      "Expected LOCATION, got #{issue_resp.action}"
    refute_nil issue_resp.authorization_code, 'authorization_code must be present'

    # Step 3: Token request
    token_resp = @sdk.tokens.process_request(
      service_id:    @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    "grant_type=authorization_code" \
                       "&code=#{issue_resp.authorization_code}" \
                       "&redirect_uri=#{encoded_redirect}",
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).token_response

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"
    refute_nil token_resp.access_token, 'access_token must be present'

    id_token = token_resp.id_token.to_s
    refute_empty id_token, 'id_token must be present for openid scope'

    # Step 4: Validate ID token payload claims
    assert_oidc_claims(
      decode_jwt_payload(id_token),
      expected_sub:       SUBJECT,
      expected_nonce:     nonce,
      expected_client_id: @client_id
    )

    # Step 5: Introspect the access token
    assert_token_valid(@sdk, @service_id, token_resp.access_token)
  end
end

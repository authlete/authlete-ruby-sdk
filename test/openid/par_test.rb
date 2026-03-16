# frozen_string_literal: true

require_relative '../test_helper'
require_relative 'openid_helper'

# =============================================================================
# OIDC PAR (Pushed Authorization Request) Flow
# PAR + scope=openid — verifies that the id_token is correctly issued when
# PAR and OIDC are combined.
# =============================================================================

class OidcParFlowTest < Minitest::Test
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

  def test_par_oidc_flow
    nonce            = SecureRandom.hex(16)
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Step 1: Push authorization parameters including scope=openid and nonce
    par_resp = @sdk.pushed_authorization.create(
      service_id:                    @service_id,
      pushed_authorization_request:  Authlete::Models::Components::PushedAuthorizationRequest.new(
        parameters:    "response_type=code&client_id=#{@client_id}" \
                       "&redirect_uri=#{encoded_redirect}" \
                       "&scope=openid&nonce=#{nonce}&state=#{STATE}",
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).pushed_authorization_response

    assert_equal 'CREATED', par_resp.action.serialize,
      "Expected CREATED, got #{par_resp.action}: #{par_resp.result_message}"
    refute_nil par_resp.request_uri, 'request_uri must be present after PAR'

    # Step 2: Authorization request using request_uri
    auth_resp = @sdk.authorization.process_request(
      service_id:            @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: "client_id=#{@client_id}" \
                    "&request_uri=#{URI.encode_www_form_component(par_resp.request_uri)}"
      )
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION, got #{auth_resp.action}"
    refute_nil auth_resp.ticket

    # Step 3: Authorization issue
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

    # Step 4: Token exchange
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
    refute_nil token_resp.access_token

    id_token = token_resp.id_token.to_s
    refute_empty id_token, 'id_token must be present for openid scope'

    # Step 5: Validate ID token payload claims
    assert_oidc_claims(
      decode_jwt_payload(id_token),
      expected_sub:       SUBJECT,
      expected_nonce:     nonce,
      expected_client_id: @client_id
    )

    # Step 6: Introspect the access token
    assert_token_valid(@sdk, @service_id, token_resp.access_token)
  end
end

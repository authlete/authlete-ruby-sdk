# frozen_string_literal: true

require 'digest'
require_relative '../test_helper'
require_relative 'openid_helper'

# =============================================================================
# OIDC PKCE (S256) Flow
# Standard PKCE S256 flow with scope=openid — verifies that the id_token is
# correctly issued when PKCE and OIDC are combined.
# =============================================================================

class OidcPkceFlowTest < Minitest::Test
  include IdpHelper
  include SdkHelper
  include OidcHelper

  def setup
    service = idp_create_oidc_service(
      'supportedGrantTypes' => %w[AUTHORIZATION_CODE]
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

  def test_pkce_s256_oidc_flow
    code_verifier    = SecureRandom.urlsafe_base64(48)
    code_challenge   = Base64.urlsafe_encode64(Digest::SHA256.digest(code_verifier), padding: false)
    nonce            = SecureRandom.hex(16)
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Step 1: Authorization request with PKCE S256 + scope=openid + nonce
    auth_resp = @sdk.authorization.process_request(
      service_id:            @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: "response_type=code&client_id=#{@client_id}" \
                    "&redirect_uri=#{encoded_redirect}" \
                    "&scope=openid&nonce=#{nonce}&state=#{STATE}" \
                    "&code_challenge=#{code_challenge}&code_challenge_method=S256"
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

    # Step 3: Token request — must include code_verifier
    token_resp = @sdk.tokens.process_request(
      service_id:    @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    "grant_type=authorization_code" \
                       "&code=#{issue_resp.authorization_code}" \
                       "&redirect_uri=#{encoded_redirect}" \
                       "&code_verifier=#{code_verifier}",
        client_id:     @client_id,
        client_secret: @client_secret
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

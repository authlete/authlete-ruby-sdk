# frozen_string_literal: true

require_relative 'test_helper'

# Shared helper for running the authorization code flow through to a token response.
module AuthCodeFlowHelper
  def do_auth_code_flow
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)
    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}" \
                 "&state=#{STATE}"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: parameters
      )
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION action, got #{auth_resp.action}"

    issue_resp = @sdk.authorization.issue_response(
      service_id: @service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket:  auth_resp.ticket,
        subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize,
      "Expected LOCATION action, got #{issue_resp.action}"

    auth_code = issue_resp.authorization_code
    token_parameters = "grant_type=authorization_code" \
                       "&code=#{auth_code}" \
                       "&redirect_uri=#{encoded_redirect}"

    @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    token_parameters,
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).token_response
  end
end

# Tests for a service that supports the REFRESH_TOKEN grant type.
class RefreshTokenFlowTest < Minitest::Test
  include SdkHelper
  include AuthCodeFlowHelper

  def setup
    @service_id = SERVICE_ID
    @sdk        = create_sdk_client(SERVICE_TOKEN)
    @sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        supported_grant_types: [
          Authlete::Models::Components::GrantType::AUTHORIZATION_CODE,
          Authlete::Models::Components::GrantType::REFRESH_TOKEN
        ],
        refresh_token_duration: 600
      )
    )
    @client        = create_test_client(@sdk, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @sdk.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
  end

  # The initial token response must include a refresh token.
  def test_refresh_token_issued
    token_resp = do_auth_code_flow

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK action for token, got #{token_resp.action}"
    refute_nil token_resp.refresh_token, 'Refresh token must not be nil'
    refute_empty token_resp.refresh_token.to_s, 'Refresh token must not be empty'
  end

  # Using a valid refresh token must return a new access token.
  def test_refresh_token_flow
    token_resp    = do_auth_code_flow
    refresh_token = token_resp.refresh_token

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK for initial token response, got #{token_resp.action}"
    refute_nil refresh_token, 'Refresh token must not be nil'

    # Exchange the refresh token for a new access token
    refresh_resp = @sdk.tokens.process_request(
      service_id:    @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    "grant_type=refresh_token&refresh_token=#{refresh_token}",
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).token_response

    assert_equal 'OK', refresh_resp.action.serialize,
      "Expected OK for refresh token response, got #{refresh_resp.action}"
    refute_nil refresh_resp.access_token, 'New access token must not be nil'

    # NOTE: introspection of refresh-token-issued access tokens is skipped due to
    # BUG-001 in test/bugs.md — the Crystalline deserializer crashes on null array
    # elements in the introspection response for this token type.
  end

  # A revoked refresh token must be rejected by the token endpoint.
  def test_refresh_token_revocation
    token_resp    = do_auth_code_flow
    refresh_token = token_resp.refresh_token

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK for initial token response, got #{token_resp.action}"
    refute_nil refresh_token, 'Refresh token must not be nil'

    # Revoke the refresh token
    revocation_resp = @sdk.revocation.process_request(
      service_id:         @service_id,
      revocation_request: Authlete::Models::Components::RevocationRequest.new(
        parameters:    "token=#{refresh_token}&token_type_hint=refresh_token",
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).revocation_response

    assert_equal 'OK', revocation_resp.action.serialize,
      "Expected OK for revocation, got #{revocation_resp.action}"

    # Attempt to use the revoked refresh token — must not succeed
    rejected_resp = @sdk.tokens.process_request(
      service_id:    @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    "grant_type=refresh_token&refresh_token=#{refresh_token}",
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).token_response

    refute_equal 'OK', rejected_resp.action.serialize,
      'Revoked refresh token must be rejected (action must not be OK)'
  end
end

# Tests for a service that does NOT support the REFRESH_TOKEN grant type.
class RefreshTokenNotSupportedTest < Minitest::Test
  include SdkHelper
  include AuthCodeFlowHelper

  def setup
    @service_id = SERVICE_ID
    @sdk        = create_sdk_client(SERVICE_TOKEN)
    @sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        supported_grant_types: [
          Authlete::Models::Components::GrantType::AUTHORIZATION_CODE
        ]
      )
    )
    @client        = create_test_client(@sdk, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @sdk.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
    # Restore REFRESH_TOKEN grant so other tests are unaffected
    @sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        supported_grant_types: [
          Authlete::Models::Components::GrantType::AUTHORIZATION_CODE,
          Authlete::Models::Components::GrantType::REFRESH_TOKEN
        ]
      )
    )
  end

  # When the service doesn't support REFRESH_TOKEN, no refresh token should be issued.
  def test_refresh_token_not_issued
    token_resp = do_auth_code_flow

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK for token response, got #{token_resp.action}"

    rt = token_resp.refresh_token.to_s
    assert rt.empty?, "Expected no refresh token, but got: #{rt}"
  end

  # Attempting to use a refresh token on a service that doesn't support it must fail.
  def test_refresh_token_rejected
    rejected_resp = @sdk.tokens.process_request(
      service_id:    @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    'grant_type=refresh_token&refresh_token=bogus_token',
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).token_response

    refute_equal 'OK', rejected_resp.action.serialize,
      'Refresh token grant must be rejected on a service that does not support it'
  end
end

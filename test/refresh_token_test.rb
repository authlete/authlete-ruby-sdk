# frozen_string_literal: true

require_relative 'test_helper'

# Shared helper: runs auth-code flow and returns the token_response.
module AuthCodeFlowHelper
  def do_auth_code_flow(sdk, service_id, client_id, client_secret)
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    auth_resp = sdk.authorization.process_request(
      service_id: service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: "response_type=code&client_id=#{client_id}" \
                    "&redirect_uri=#{encoded_redirect}&state=#{STATE}"
      )
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION, got #{auth_resp.action}"

    issue_resp = sdk.authorization.issue_response(
      service_id: service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket: auth_resp.ticket, subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize,
      "Expected LOCATION, got #{issue_resp.action}"

    token_resp = sdk.tokens.process_request(
      service_id: service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    "grant_type=authorization_code" \
                       "&code=#{issue_resp.authorization_code}" \
                       "&redirect_uri=#{encoded_redirect}",
        client_id:     client_id,
        client_secret: client_secret
      )
    ).token_response

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK at token endpoint, got #{token_resp.action}: #{token_resp.result_message}"

    token_resp
  end
end

# =============================================================================
# Service with both AUTHORIZATION_CODE and REFRESH_TOKEN grant types enabled.
# Verifies that refresh tokens are issued, can be exchanged, and can be revoked.
# =============================================================================

class RefreshTokenFlowTest < Minitest::Test
  include SdkHelper
  include AuthCodeFlowHelper

  def setup
    @service_id    = SERVICE_ID
    @mgmt_authlete_client      = create_sdk_client(MGMT_TOKEN)
    @authlete_client           = create_sdk_client(SERVICE_TOKEN)
    @mgmt_authlete_client.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        supported_grant_types: [
          Authlete::Models::Components::GrantType::AUTHORIZATION_CODE,
          Authlete::Models::Components::GrantType::REFRESH_TOKEN
        ],
        access_token_duration:  TOKEN_DURATION_SECONDS,
        refresh_token_duration: TOKEN_DURATION_SECONDS
      )
    )
    @client        = create_test_client(@mgmt_authlete_client, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @mgmt_authlete_client.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
  end

  # A refresh token must be issued alongside the access token
  def test_refresh_token_issued
    token_resp = do_auth_code_flow(@authlete_client, @service_id, @client_id, @client_secret)
    refute_nil token_resp.refresh_token,
      'Refresh token must be issued when the refresh_token grant type is supported'
  end

  # Exchanging a refresh token must yield a new access token
  def test_refresh_token_flow
    token_resp    = do_auth_code_flow(@authlete_client, @service_id, @client_id, @client_secret)
    refresh_token = token_resp.refresh_token
    refute_nil refresh_token, 'Refresh token must be issued'

    refresh_resp = @authlete_client.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    "grant_type=refresh_token&refresh_token=#{refresh_token}",
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).token_response

    assert_equal 'OK', refresh_resp.action.serialize,
      "Expected OK for refresh token exchange, got #{refresh_resp.action}: #{refresh_resp.result_message}"
    refute_nil refresh_resp.access_token, 'New access token must be issued on refresh'

    # Introspect the new access token.
    intro_resp = @authlete_client.introspection.process_request(
      service_id: @service_id,
      introspection_request: Authlete::Models::Components::IntrospectionRequest.new(
        token: refresh_resp.access_token
      )
    ).introspection_response

    assert_equal 'OK', intro_resp.action.serialize,
      "Expected OK for introspection of refreshed access token, got #{intro_resp.action}"
  end

  # Revoking a refresh token must succeed
  def test_refresh_token_revocation
    token_resp    = do_auth_code_flow(@authlete_client, @service_id, @client_id, @client_secret)
    refresh_token = token_resp.refresh_token
    refute_nil refresh_token, 'Refresh token must be issued'

    revocation_resp = @authlete_client.revocation.process_request(
      service_id: @service_id,
      revocation_request: Authlete::Models::Components::RevocationRequest.new(
        parameters:    "token=#{refresh_token}",
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).revocation_response

    assert_equal 'OK', revocation_resp.action.serialize,
      "Expected OK for refresh token revocation, got #{revocation_resp.action}"
  end
end

# =============================================================================
# Service with only AUTHORIZATION_CODE grant type (REFRESH_TOKEN not supported).
# Verifies that refresh tokens are not issued and the refresh_token grant is rejected.
# =============================================================================

class RefreshTokenNotSupportedTest < Minitest::Test
  include SdkHelper
  include AuthCodeFlowHelper

  def setup
    @service_id    = SERVICE_ID
    @mgmt_authlete_client      = create_sdk_client(MGMT_TOKEN)
    @authlete_client           = create_sdk_client(SERVICE_TOKEN)
    @mgmt_authlete_client.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        supported_grant_types: [
          Authlete::Models::Components::GrantType::AUTHORIZATION_CODE
        ],
        access_token_duration:  TOKEN_DURATION_SECONDS,
        refresh_token_duration: TOKEN_DURATION_SECONDS
      )
    )
    @client        = create_test_client(@mgmt_authlete_client, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @mgmt_authlete_client.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
    @mgmt_authlete_client.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        supported_grant_types: [
          Authlete::Models::Components::GrantType::AUTHORIZATION_CODE,
          Authlete::Models::Components::GrantType::REFRESH_TOKEN
        ],
        access_token_duration:  TOKEN_DURATION_SECONDS,
        refresh_token_duration: TOKEN_DURATION_SECONDS
      )
    )
  end

  # No refresh token must be issued when the grant type is not supported
  def test_refresh_token_not_issued
    token_resp = do_auth_code_flow(@authlete_client, @service_id, @client_id, @client_secret)
    assert_nil token_resp.refresh_token,
      'Refresh token must not be issued when the refresh_token grant type is not supported'
  end

  # The refresh_token grant must be rejected when not supported by the service
  def test_refresh_token_rejected
    token_resp = @authlete_client.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    'grant_type=refresh_token&refresh_token=dummy_token',
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).token_response

    refute_equal 'OK', token_resp.action.serialize,
      'Refresh token grant must be rejected when not supported by the service'
  end
end

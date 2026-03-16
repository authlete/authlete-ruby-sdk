# frozen_string_literal: true

require 'digest'
require_relative 'test_helper'

module PkceHelper
  def generate_code_verifier
    # RFC 7636: 43-128 chars of unreserved characters
    SecureRandom.urlsafe_base64(48)
  end

  def s256_code_challenge(code_verifier)
    Base64.urlsafe_encode64(Digest::SHA256.digest(code_verifier), padding: false)
  end
end

# =============================================================================
# Standard service — PKCE is optional (clients may use it or skip it).
# These tests verify that PKCE works correctly when a client voluntarily uses it,
# and that a mismatched code_verifier is rejected at the token endpoint.
# =============================================================================

class PkceFlowTest < Minitest::Test
  include SdkHelper
  include PkceHelper

  def setup
    @service_id    = SERVICE_ID
    @mgmt_sdk      = create_sdk_client(MGMT_TOKEN)
    @sdk           = create_sdk_client(SERVICE_TOKEN)
    @mgmt_sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        access_token_duration: TOKEN_DURATION_SECONDS
      )
    )
    @client        = create_test_client(@mgmt_sdk, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @mgmt_sdk.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
  end

  # S256 happy path: code_verifier verified at token endpoint
  def test_pkce_s256_flow
    code_verifier  = generate_code_verifier
    code_challenge = s256_code_challenge(code_verifier)
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Step 1: Authorization request with code_challenge + S256
    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}" \
                 "&state=#{STATE}" \
                 "&code_challenge=#{code_challenge}&code_challenge_method=S256"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(parameters: parameters)
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION, got #{auth_resp.action}"
    refute_nil auth_resp.ticket

    # Step 2: Issue authorization code
    issue_resp = @sdk.authorization.issue_response(
      service_id: @service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket: auth_resp.ticket, subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize,
      "Expected LOCATION, got #{issue_resp.action}"
    refute_nil issue_resp.authorization_code

    # Step 3: Token request — must include code_verifier
    token_params = "grant_type=authorization_code" \
                   "&code=#{issue_resp.authorization_code}" \
                   "&redirect_uri=#{encoded_redirect}" \
                   "&code_verifier=#{code_verifier}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters: token_params, client_id: @client_id, client_secret: @client_secret
      )
    ).token_response

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"
    refute_nil token_resp.access_token
    assert_token_valid(@sdk, @service_id, token_resp.access_token)
  end

  # plain happy path: code_challenge == code_verifier
  def test_pkce_plain_flow
    code_verifier    = generate_code_verifier
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}" \
                 "&state=#{STATE}" \
                 "&code_challenge=#{code_verifier}&code_challenge_method=plain"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(parameters: parameters)
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION, got #{auth_resp.action}"

    issue_resp = @sdk.authorization.issue_response(
      service_id: @service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket: auth_resp.ticket, subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize,
      "Expected LOCATION, got #{issue_resp.action}"

    token_params = "grant_type=authorization_code" \
                   "&code=#{issue_resp.authorization_code}" \
                   "&redirect_uri=#{encoded_redirect}" \
                   "&code_verifier=#{code_verifier}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters: token_params, client_id: @client_id, client_secret: @client_secret
      )
    ).token_response

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"
    refute_nil token_resp.access_token
    assert_token_valid(@sdk, @service_id, token_resp.access_token)
  end

  # A mismatched code_verifier must be rejected at the token endpoint
  def test_wrong_code_verifier_rejected
    code_verifier    = generate_code_verifier
    code_challenge   = s256_code_challenge(code_verifier)
    wrong_verifier   = generate_code_verifier # intentionally different
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}" \
                 "&state=#{STATE}" \
                 "&code_challenge=#{code_challenge}&code_challenge_method=S256"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(parameters: parameters)
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize

    issue_resp = @sdk.authorization.issue_response(
      service_id: @service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket: auth_resp.ticket, subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize

    token_params = "grant_type=authorization_code" \
                   "&code=#{issue_resp.authorization_code}" \
                   "&redirect_uri=#{encoded_redirect}" \
                   "&code_verifier=#{wrong_verifier}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters: token_params, client_id: @client_id, client_secret: @client_secret
      )
    ).token_response

    refute_equal 'OK', token_resp.action.serialize,
      'Token request with wrong code_verifier must not succeed'
  end
end

# =============================================================================
# Service with pkceRequired: true
# =============================================================================

class PkceRequiredTest < Minitest::Test
  include SdkHelper
  include PkceHelper

  def setup
    @service_id    = SERVICE_ID
    @mgmt_sdk      = create_sdk_client(MGMT_TOKEN)
    @sdk           = create_sdk_client(SERVICE_TOKEN)
    @mgmt_sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        pkce_required: true, access_token_duration: TOKEN_DURATION_SECONDS
      )
    )
    @client        = create_test_client(@mgmt_sdk, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @mgmt_sdk.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
    @mgmt_sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        pkce_required: false, access_token_duration: TOKEN_DURATION_SECONDS
      )
    )
  end

  # Auth request without code_challenge must be rejected
  def test_missing_code_challenge_rejected
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)
    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}&state=#{STATE}"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(parameters: parameters)
    ).authorization_response

    refute_equal 'INTERACTION', auth_resp.action.serialize,
      'Auth request without code_challenge must be rejected when pkceRequired=true'
  end

  # Valid S256 PKCE flow must still succeed
  def test_pkce_s256_flow_succeeds
    code_verifier    = generate_code_verifier
    code_challenge   = s256_code_challenge(code_verifier)
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}" \
                 "&state=#{STATE}" \
                 "&code_challenge=#{code_challenge}&code_challenge_method=S256"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(parameters: parameters)
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION, got #{auth_resp.action}"

    issue_resp = @sdk.authorization.issue_response(
      service_id: @service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket: auth_resp.ticket, subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize

    token_params = "grant_type=authorization_code" \
                   "&code=#{issue_resp.authorization_code}" \
                   "&redirect_uri=#{encoded_redirect}" \
                   "&code_verifier=#{code_verifier}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters: token_params, client_id: @client_id, client_secret: @client_secret
      )
    ).token_response

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"
    refute_nil token_resp.access_token
    assert_token_valid(@sdk, @service_id, token_resp.access_token)
  end
end

# =============================================================================
# Service with pkceS256Required: true
# =============================================================================

class PkceS256RequiredTest < Minitest::Test
  include SdkHelper
  include PkceHelper

  def setup
    @service_id    = SERVICE_ID
    @mgmt_sdk      = create_sdk_client(MGMT_TOKEN)
    @sdk           = create_sdk_client(SERVICE_TOKEN)
    @mgmt_sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        pkce_s256_required: true, access_token_duration: TOKEN_DURATION_SECONDS
      )
    )
    @client        = create_test_client(@mgmt_sdk, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @mgmt_sdk.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
    @mgmt_sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        pkce_s256_required: false, access_token_duration: TOKEN_DURATION_SECONDS
      )
    )
  end

  # plain method must be rejected when S256 is required
  def test_plain_method_rejected
    code_verifier    = generate_code_verifier
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}" \
                 "&state=#{STATE}" \
                 "&code_challenge=#{code_verifier}&code_challenge_method=plain"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(parameters: parameters)
    ).authorization_response

    refute_equal 'INTERACTION', auth_resp.action.serialize,
      'plain code_challenge_method must be rejected when pkceS256Required=true'
  end

  # S256 must still succeed
  def test_s256_flow_succeeds
    code_verifier    = generate_code_verifier
    code_challenge   = s256_code_challenge(code_verifier)
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}" \
                 "&state=#{STATE}" \
                 "&code_challenge=#{code_challenge}&code_challenge_method=S256"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(parameters: parameters)
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION, got #{auth_resp.action}"

    issue_resp = @sdk.authorization.issue_response(
      service_id: @service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket: auth_resp.ticket, subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize

    token_params = "grant_type=authorization_code" \
                   "&code=#{issue_resp.authorization_code}" \
                   "&redirect_uri=#{encoded_redirect}" \
                   "&code_verifier=#{code_verifier}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters: token_params, client_id: @client_id, client_secret: @client_secret
      )
    ).token_response

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"
    refute_nil token_resp.access_token
    assert_token_valid(@sdk, @service_id, token_resp.access_token)
  end
end

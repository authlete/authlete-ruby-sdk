# frozen_string_literal: true

require_relative 'test_helper'

# =============================================================================
# Standard service — DPoP is optional (clients may use it or skip it).
# These tests verify that DPoP token binding works correctly when used,
# and that introspection correctly validates DPoP-bound tokens.
# =============================================================================

class DpopFlowTest < Minitest::Test
  include IdpHelper
  include SdkHelper
  include DpopHelper

  def setup
    service = idp_create_service(
      'supportedGrantTypes'    => %w[AUTHORIZATION_CODE],
      'supportedResponseTypes' => %w[CODE],
      'accessTokenDuration'    => 600,
      'refreshTokenDuration'   => 600,
      'tokenEndpoint'          => DpopHelper::TOKEN_ENDPOINT
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

  # Core DPoP success path: token endpoint accepts DPoP proof and issues a
  # DPoP-bound access token.
  def test_dpop_basic_flow
    key = generate_ec_key
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Step 1: Authorization request (no DPoP needed at auth endpoint)
    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}&state=#{STATE}"

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

    # Step 3: Token request with DPoP proof
    token_params = "grant_type=authorization_code" \
                   "&code=#{issue_resp.authorization_code}" \
                   "&redirect_uri=#{encoded_redirect}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    token_params,
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
  end

  # DPoP-bound access token must be accepted at introspection when a valid
  # DPoP proof (including ath) is provided.
  def test_dpop_introspection_valid
    key = generate_ec_key
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Obtain DPoP-bound access token
    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: "response_type=code&client_id=#{@client_id}" \
                    "&redirect_uri=#{encoded_redirect}&state=#{STATE}"
      )
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
                   "&redirect_uri=#{encoded_redirect}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    token_params,
        client_id:     @client_id,
        client_secret: @client_secret,
        dpop:          dpop_proof(key, 'POST', TOKEN_ENDPOINT),
        htm:           'POST',
        htu:           TOKEN_ENDPOINT
      )
    ).token_response

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK at token endpoint, got #{token_resp.action}: #{token_resp.result_message}"
    access_token = token_resp.access_token
    refute_nil access_token

    # Introspect with a valid DPoP proof (htm=GET, ath=SHA256 of access token)
    intro_resp = @sdk.introspection.process_request(
      service_id: @service_id,
      introspection_request: Authlete::Models::Components::IntrospectionRequest.new(
        token: access_token,
        dpop:  dpop_proof(key, 'GET', RESOURCE_URL, access_token: access_token),
        htm:   'GET',
        htu:   RESOURCE_URL
      )
    ).introspection_response

    assert_equal 'OK', intro_resp.action.serialize,
      "Expected OK at introspection, got #{intro_resp.action}: #{intro_resp.result_message}"
  end

  # Introspecting a DPoP-bound access token without a DPoP proof must be
  # rejected (Authlete should return UNAUTHORIZED or BAD_REQUEST, not OK).
  def test_dpop_introspection_without_proof_rejected
    key = generate_ec_key
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: "response_type=code&client_id=#{@client_id}" \
                    "&redirect_uri=#{encoded_redirect}&state=#{STATE}"
      )
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
                   "&redirect_uri=#{encoded_redirect}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    token_params,
        client_id:     @client_id,
        client_secret: @client_secret,
        dpop:          dpop_proof(key, 'POST', TOKEN_ENDPOINT),
        htm:           'POST',
        htu:           TOKEN_ENDPOINT
      )
    ).token_response

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK at token endpoint, got #{token_resp.action}: #{token_resp.result_message}"
    access_token = token_resp.access_token
    refute_nil access_token

    # Introspect without any DPoP proof — must not return OK
    intro_resp = @sdk.introspection.process_request(
      service_id: @service_id,
      introspection_request: Authlete::Models::Components::IntrospectionRequest.new(
        token: access_token
      )
    ).introspection_response

    refute_equal 'OK', intro_resp.action.serialize,
      'Introspecting a DPoP-bound token without a proof must not return OK'
  end
end

# =============================================================================
# Client with dpopRequired: true
# These tests verify that the server rejects token requests without a DPoP
# proof when the client is configured to require DPoP.
# =============================================================================

class DpopRequiredTest < Minitest::Test
  include IdpHelper
  include SdkHelper
  include DpopHelper

  def setup
    service = idp_create_service(
      'supportedGrantTypes'    => %w[AUTHORIZATION_CODE],
      'supportedResponseTypes' => %w[CODE],
      'accessTokenDuration'    => 600,
      'refreshTokenDuration'   => 600,
      'tokenEndpoint'          => DpopHelper::TOKEN_ENDPOINT
    )
    @service_api_key = service['apiKey']
    @service_id      = @service_api_key.to_s
    @sdk             = create_sdk_client(ORG_TOKEN)

    # Create a client with dpop_required: true
    client_input = Authlete::Models::Components::ClientInput.new(
      client_name:    "ruby-sdk-test-dpop-required-#{Time.now.to_i}",
      client_type:    Authlete::Models::Components::ClientType::CONFIDENTIAL,
      grant_types:    [Authlete::Models::Components::GrantType::AUTHORIZATION_CODE],
      response_types: [Authlete::Models::Components::ResponseType::CODE],
      redirect_uris:  [REDIRECT_URI],
      dpop_required:  true
    )
    resp = @sdk.clients.create(service_id: @service_id, client: client_input)
    @client        = resp.client
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    idp_delete_service(@service_api_key) if @service_api_key
  end

  # Token request without a DPoP proof must be rejected when dpopRequired=true.
  def test_token_without_dpop_rejected
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: "response_type=code&client_id=#{@client_id}" \
                    "&redirect_uri=#{encoded_redirect}&state=#{STATE}"
      )
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
                   "&redirect_uri=#{encoded_redirect}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    token_params,
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).token_response

    refute_equal 'OK', token_resp.action.serialize,
      'Token request without DPoP proof must not succeed when dpopRequired=true'
  end

  # Full DPoP flow must succeed even when dpopRequired=true.
  def test_dpop_flow_succeeds_when_required
    key = generate_ec_key
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: "response_type=code&client_id=#{@client_id}" \
                    "&redirect_uri=#{encoded_redirect}&state=#{STATE}"
      )
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
                   "&redirect_uri=#{encoded_redirect}"

    token_resp = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: Authlete::Models::Components::TokenRequest.new(
        parameters:    token_params,
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
  end
end

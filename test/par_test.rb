# frozen_string_literal: true

require_relative 'test_helper'

# =============================================================================
# Standard service — PAR is optional. Tests verify the SDK correctly handles
# the PAR flow end-to-end (success and error paths).
# =============================================================================

class ParFlowTest < Minitest::Test
  include SdkHelper

  def setup
    @service_id    = SERVICE_ID
    @sdk           = create_sdk_client(SERVICE_TOKEN)
    @sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        access_token_duration: TOKEN_DURATION_SECONDS
      )
    )
    @client        = create_test_client(@sdk, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @sdk.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
  end

  # Core SDK integration test: PAR success path
  # 1. Build PushedAuthorizationRequest with form-encoded params
  # 2. Call sdk.pushed_authorization.create() → assert CREATED, request_uri present
  # 3. Use request_uri in auth request → assert INTERACTION
  # 4. Issue auth code → assert LOCATION
  # 5. Exchange for token → assert OK, access_token present
  def test_par_basic_flow
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Step 1: Push authorization parameters
    par_params = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}&state=#{STATE}"

    par_resp = @sdk.pushed_authorization.create(
      service_id: @service_id,
      pushed_authorization_request: Authlete::Models::Components::PushedAuthorizationRequest.new(
        parameters:    par_params,
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).pushed_authorization_response

    assert_equal 'CREATED', par_resp.action.serialize,
      "Expected CREATED, got #{par_resp.action}: #{par_resp.result_message}"
    refute_nil par_resp.request_uri, 'request_uri must be present after PAR'

    request_uri = par_resp.request_uri

    # Step 2: Authorization request using request_uri
    auth_params = "client_id=#{@client_id}&request_uri=#{URI.encode_www_form_component(request_uri)}"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: auth_params
      )
    ).authorization_response

    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION, got #{auth_resp.action}"
    refute_nil auth_resp.ticket

    # Step 3: Issue authorization code
    issue_resp = @sdk.authorization.issue_response(
      service_id: @service_id,
      authorization_issue_request: Authlete::Models::Components::AuthorizationIssueRequest.new(
        ticket: auth_resp.ticket, subject: SUBJECT
      )
    ).authorization_issue_response

    assert_equal 'LOCATION', issue_resp.action.serialize,
      "Expected LOCATION, got #{issue_resp.action}"
    refute_nil issue_resp.authorization_code

    # Step 4: Token exchange
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

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"
    refute_nil token_resp.access_token
    assert_token_valid(@sdk, @service_id, token_resp.access_token)
  end

  # SDK error-handling test: omitting client_secret for a confidential client
  # must surface a non-CREATED action rather than crashing or swallowing the error.
  def test_par_missing_client_secret_rejected
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    par_params = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}&state=#{STATE}"

    par_resp = @sdk.pushed_authorization.create(
      service_id: @service_id,
      pushed_authorization_request: Authlete::Models::Components::PushedAuthorizationRequest.new(
        parameters: par_params,
        client_id:  @client_id
        # client_secret intentionally omitted
      )
    ).pushed_authorization_response

    refute_equal 'CREATED', par_resp.action.serialize,
      'PAR request without client_secret must not succeed for a confidential client'
  end
end

# =============================================================================
# Service with parRequired: true
# =============================================================================

class ParRequiredTest < Minitest::Test
  include SdkHelper

  def setup
    @service_id    = SERVICE_ID
    @sdk           = create_sdk_client(SERVICE_TOKEN)
    @sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        par_required: true, access_token_duration: TOKEN_DURATION_SECONDS
      )
    )
    @client        = create_test_client(@sdk, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @sdk.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
    @sdk.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        par_required: false, access_token_duration: TOKEN_DURATION_SECONDS
      )
    )
  end

  # A direct authorization request (without PAR) must be rejected when parRequired=true
  def test_direct_auth_request_rejected
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)
    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}&state=#{STATE}"

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: parameters
      )
    ).authorization_response

    refute_equal 'INTERACTION', auth_resp.action.serialize,
      'Direct auth request must be rejected when parRequired=true'
  end

  # Full PAR flow must succeed even when parRequired=true
  def test_par_flow_succeeds_when_required
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    par_params = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}&state=#{STATE}"

    par_resp = @sdk.pushed_authorization.create(
      service_id: @service_id,
      pushed_authorization_request: Authlete::Models::Components::PushedAuthorizationRequest.new(
        parameters:    par_params,
        client_id:     @client_id,
        client_secret: @client_secret
      )
    ).pushed_authorization_response

    assert_equal 'CREATED', par_resp.action.serialize,
      "Expected CREATED, got #{par_resp.action}: #{par_resp.result_message}"
    refute_nil par_resp.request_uri

    request_uri = par_resp.request_uri

    auth_resp = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: Authlete::Models::Components::AuthorizationRequest.new(
        parameters: "client_id=#{@client_id}&request_uri=#{URI.encode_www_form_component(request_uri)}"
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

    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"
    refute_nil token_resp.access_token
    assert_token_valid(@sdk, @service_id, token_resp.access_token)
  end
end

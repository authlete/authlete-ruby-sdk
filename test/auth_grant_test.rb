# frozen_string_literal: true

require_relative 'test_helper'

class AuthGrantFlowTest < Minitest::Test
  include SdkHelper

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

  def test_authorization_code_flow
    # --- Step 1: Authorization Request ---
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)
    parameters = "response_type=code&client_id=#{@client_id}" \
                 "&redirect_uri=#{encoded_redirect}" \
                 "&state=#{STATE}"

    auth_request = Authlete::Models::Components::AuthorizationRequest.new(
      parameters: parameters
    )
    response = @sdk.authorization.process_request(
      service_id: @service_id,
      authorization_request: auth_request
    )

    auth_resp = response.authorization_response
    assert_equal 'INTERACTION', auth_resp.action.serialize,
      "Expected INTERACTION action, got #{auth_resp.action}"

    ticket = auth_resp.ticket
    refute_nil ticket, 'Authorization ticket must not be nil'

    # --- Step 2: Authorization Issue (simulate user consent) ---
    issue_request = Authlete::Models::Components::AuthorizationIssueRequest.new(
      ticket: ticket,
      subject: SUBJECT
    )
    response = @sdk.authorization.issue_response(
      service_id: @service_id,
      authorization_issue_request: issue_request
    )

    issue_resp = response.authorization_issue_response
    assert_equal 'LOCATION', issue_resp.action.serialize,
      "Expected LOCATION action, got #{issue_resp.action}"

    auth_code = issue_resp.authorization_code
    refute_nil auth_code, 'Authorization code must not be nil'

    assert_includes issue_resp.response_content, 'code=',
      'Response content must contain code='
    assert_includes issue_resp.response_content, "state=#{STATE}",
      'Response content must contain state='

    # --- Step 3: Token Request ---
    token_request = Authlete::Models::Components::TokenRequest.new(
      parameters:    "grant_type=authorization_code" \
                     "&code=#{auth_code}" \
                     "&redirect_uri=#{encoded_redirect}",
      client_id:     @client_id,
      client_secret: @client_secret
    )
    response = @sdk.tokens.process_request(
      service_id: @service_id,
      token_request: token_request
    )

    token_resp = response.token_response
    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK action for token, got #{token_resp.action}"

    access_token = token_resp.access_token
    refute_nil access_token, 'Access token must not be nil'

    # --- Step 4: Introspection ---
    introspection_request = Authlete::Models::Components::IntrospectionRequest.new(
      token: access_token
    )
    response = @sdk.introspection.process_request(
      service_id: @service_id,
      introspection_request: introspection_request
    )

    intro_resp = response.introspection_response
    assert_equal 'OK', intro_resp.action.serialize,
      "Expected OK action for introspection, got #{intro_resp.action}: #{intro_resp.result_message}"

    # --- Step 5: Revocation ---
    revocation_request = Authlete::Models::Components::RevocationRequest.new(
      parameters:    "token=#{access_token}",
      client_id:     @client_id,
      client_secret: @client_secret
    )
    response = @sdk.revocation.process_request(
      service_id: @service_id,
      revocation_request: revocation_request
    )

    revocation_resp = response.revocation_response
    assert_equal 'OK', revocation_resp.action.serialize,
      "Expected OK action for revocation, got #{revocation_resp.action}"
  end
end

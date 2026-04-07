# frozen_string_literal: true

require_relative 'test_helper'

# =============================================================================
# Extra Properties
# Properties can be attached to access tokens at authorization issue or at the
# token endpoint. Each property has a key, value, and hidden flag.
#
# Ref: https://www.authlete.com/developers/definitive_guide/extra_properties/
# =============================================================================

class ExtraPropertiesTest < Minitest::Test
  include SdkHelper

  Property = Authlete::Models::Components::Property

  VISIBLE_PROP = Property.new(key: 'tenant_id', value: 'acme-corp')
  HIDDEN_PROP  = Property.new(key: 'internal_user_tier', value: 'premium', hidden: true)

  def setup
    @service_id    = SERVICE_ID
    @mgmt_authlete_client      = create_sdk_client(MGMT_TOKEN)
    @authlete_client           = create_sdk_client(SERVICE_TOKEN)
    @mgmt_authlete_client.services.update(
      service_id: @service_id,
      service: Authlete::Models::Components::ServiceInput.new(
        access_token_duration: TOKEN_DURATION_SECONDS
      )
    )
    @client        = create_test_client(@mgmt_authlete_client, @service_id)
    @client_id     = @client.client_id.to_s
    @client_secret = @client.client_secret
  end

  def teardown
    @mgmt_authlete_client.clients.destroy(service_id: @service_id, client_id: @client_id) if @client_id
  end

  # Sets visible + hidden properties at authorization issue and verifies the SDK
  # correctly deserializes them in the token and introspection responses.
  def test_properties_at_authorization_issue
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Authorization issue — attach properties here
    issue_request = Authlete::Models::Components::AuthorizationIssueRequest.new(
      ticket:     obtain_ticket,
      subject:    SUBJECT,
      properties: [VISIBLE_PROP, HIDDEN_PROP]
    )
    issue_resp = @authlete_client.authorization.issue_response(
      service_id: @service_id, authorization_issue_request: issue_request
    ).authorization_issue_response
    assert_equal 'LOCATION', issue_resp.action.serialize

    # Token request — no properties here
    token_request = Authlete::Models::Components::TokenRequest.new(
      parameters:    "grant_type=authorization_code&code=#{issue_resp.authorization_code}" \
                     "&redirect_uri=#{encoded_redirect}",
      client_id:     @client_id,
      client_secret: @client_secret
    )
    token_resp = @authlete_client.tokens.process_request(
      service_id: @service_id, token_request: token_request
    ).token_response
    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"

    # SDK deserializes properties array with correct key/value/hidden fields
    props = Array(token_resp.properties)
    visible = props.find { |p| p.key == VISIBLE_PROP.key }
    hidden  = props.find { |p| p.key == HIDDEN_PROP.key }
    refute_nil visible, 'Visible property must be in properties array'
    refute_nil hidden,  'Hidden property must be in properties array'
    assert_equal VISIBLE_PROP.value, visible.value
    assert_equal HIDDEN_PROP.value,  hidden.value
    assert hidden.hidden, 'Hidden flag must be true'

    # Only visible property appears in response_content
    response_json = JSON.parse(token_resp.response_content)
    assert_equal VISIBLE_PROP.value, response_json[VISIBLE_PROP.key]
    assert_nil response_json[HIDDEN_PROP.key]

    # Both accessible via introspection
    intro_request = Authlete::Models::Components::IntrospectionRequest.new(
      token: token_resp.access_token
    )
    intro_props = Array(@authlete_client.introspection.process_request(
      service_id: @service_id, introspection_request: intro_request
    ).introspection_response.properties)
    assert intro_props.any? { |p| p.key == VISIBLE_PROP.key }
    assert intro_props.any? { |p| p.key == HIDDEN_PROP.key }
  end

  # TokenRequest.properties should accept Array[Property] just like
  # AuthorizationIssueRequest.
  def test_properties_at_token_endpoint
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)

    # Authorization issue — no properties here
    issue_request = Authlete::Models::Components::AuthorizationIssueRequest.new(
      ticket: obtain_ticket, subject: SUBJECT
    )
    issue_resp = @authlete_client.authorization.issue_response(
      service_id: @service_id, authorization_issue_request: issue_request
    ).authorization_issue_response
    assert_equal 'LOCATION', issue_resp.action.serialize

    # Token request — attach properties here
    token_request = Authlete::Models::Components::TokenRequest.new(
      parameters:    "grant_type=authorization_code&code=#{issue_resp.authorization_code}" \
                     "&redirect_uri=#{encoded_redirect}",
      client_id:     @client_id,
      client_secret: @client_secret,
      properties:    [VISIBLE_PROP]
    )
    token_resp = @authlete_client.tokens.process_request(
      service_id: @service_id, token_request: token_request
    ).token_response
    assert_equal 'OK', token_resp.action.serialize,
      "Expected OK, got #{token_resp.action}: #{token_resp.result_message}"

    response_json = JSON.parse(token_resp.response_content)
    assert_equal VISIBLE_PROP.value, response_json[VISIBLE_PROP.key]
  end

  private

  def obtain_ticket
    encoded_redirect = URI.encode_www_form_component(REDIRECT_URI)
    auth_request = Authlete::Models::Components::AuthorizationRequest.new(
      parameters: "response_type=code&client_id=#{@client_id}" \
                  "&redirect_uri=#{encoded_redirect}&state=#{STATE}"
    )
    auth_resp = @authlete_client.authorization.process_request(
      service_id: @service_id, authorization_request: auth_request
    ).authorization_response
    assert_equal 'INTERACTION', auth_resp.action.serialize
    auth_resp.ticket
  end
end

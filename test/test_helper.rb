# frozen_string_literal: true

require 'minitest/autorun'
require 'faraday'
require 'json'
require 'uri'
require 'authlete_ruby_sdk'

# IDP and environment configuration
IDP_BASE_URL   = ENV.fetch('IDP_BASE_URL')
API_BASE_URL   = ENV.fetch('API_BASE_URL')
ORG_TOKEN      = ENV.fetch('AUTHLETE_ORG_TOKEN')
ORG_ID         = ENV.fetch('ORG_ID').to_i
API_SERVER_ID  = ENV.fetch('API_SERVER_ID').to_i

# OAuth flow constants
REDIRECT_URI = 'https://client.example.com/callback'
STATE        = 'testState'
SUBJECT      = 'testuser'

module IdpHelper
  # Faraday connection to the IDP, reused across calls.
  def idp_conn
    @idp_conn ||= Faraday.new(url: IDP_BASE_URL) do |f|
      f.request :json
      f.response :json
      f.adapter Faraday.default_adapter
    end
  end

  # Create a service via the IDP API.
  # Returns the parsed Service object (hash with string keys).
  def idp_create_service(service_params = {})
    body = {
      apiServerId: API_SERVER_ID,
      organizationId: ORG_ID,
      service: service_params
    }

    resp = idp_conn.post('/api/service') do |req|
      req.headers['Authorization'] = "Bearer #{ORG_TOKEN}"
      req.body = body
    end

    unless resp.success?
      raise "IDP create service failed (#{resp.status}): #{resp.body}"
    end

    resp.body
  end

  # Create a service access token via the IDP API.
  # Returns the access token string.
  def idp_create_service_token(service_id)
    body = {
      organizationId: ORG_ID,
      apiServerId: API_SERVER_ID,
      serviceId: service_id,
      description: "ruby-sdk-test-#{Time.now.to_i}"
    }

    resp = idp_conn.post('/api/servicetoken/create') do |req|
      req.headers['Authorization'] = "Bearer #{ORG_TOKEN}"
      req.body = body
    end

    unless resp.success?
      raise "IDP create service token failed (#{resp.status}): #{resp.body}"
    end

    resp.body['accessToken']
  end

  # Delete a service via the IDP API.
  def idp_delete_service(service_id)
    body = {
      apiServerId: API_SERVER_ID,
      organizationId: ORG_ID,
      serviceId: service_id
    }

    resp = idp_conn.post('/api/service/remove') do |req|
      req.headers['Authorization'] = "Bearer #{ORG_TOKEN}"
      req.body = body
    end

    # 204 or 200 are both acceptable
    unless resp.status == 204 || resp.success?
      warn "IDP delete service failed (#{resp.status}): #{resp.body}"
    end
  end
end

module SdkHelper
  # Create an Authlete SDK client authenticated with the given service token.
  def create_sdk_client(service_token)
    Authlete::Client.new(
      bearer: service_token,
      server_url: API_BASE_URL
    )
  end

  # Create a confidential OAuth client on the given service via the SDK.
  # Returns the Client object from the SDK response.
  def create_test_client(sdk_client, service_id)
    client_input = Authlete::Models::Components::ClientInput.new(
      client_name: "ruby-sdk-test-client-#{Time.now.to_i}",
      client_type: Authlete::Models::Components::ClientType::CONFIDENTIAL,
      grant_types: [
        Authlete::Models::Components::GrantType::AUTHORIZATION_CODE,
        Authlete::Models::Components::GrantType::REFRESH_TOKEN
      ],
      response_types: [
        Authlete::Models::Components::ResponseType::CODE
      ],
      redirect_uris: [REDIRECT_URI]
    )

    resp = sdk_client.clients.create(
      service_id: service_id.to_s,
      client: client_input
    )

    resp.client
  end
end

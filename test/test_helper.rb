# frozen_string_literal: true

require 'minitest/autorun'
require 'faraday'
require 'json'
require 'uri'
require 'openssl'
require 'base64'
require 'securerandom'
require 'digest'
require 'authlete_ruby_sdk'

# Environment configuration
API_BASE_URL  = ENV.fetch('API_BASE_URL')
SERVICE_ID    = ENV.fetch('SERVICE_ID',    nil)
SERVICE_TOKEN = ENV.fetch('SERVICE_TOKEN', nil)

# IDP-related — only required for tests that manage service lifecycle via the IDP
IDP_BASE_URL  = ENV.fetch('IDP_BASE_URL',        nil)
ORG_TOKEN     = ENV.fetch('AUTHLETE_ORG_TOKEN',  nil)
ORG_ID        = ENV.fetch('ORG_ID',  '0').to_i
API_SERVER_ID = ENV.fetch('API_SERVER_ID', '0').to_i

# OAuth flow constants
REDIRECT_URI           = 'https://client.example.com/callback'
STATE                  = 'testState'
SUBJECT                = 'testuser'
TOKEN_DURATION_SECONDS = 600 # 10 minutes — long enough for any test to complete

module DpopHelper
  TOKEN_ENDPOINT = 'https://as.example.com/token'
  RESOURCE_URL   = 'https://rs.example.com/api/resource'
  USERINFO_URL   = 'https://as.example.com/userinfo'

  def generate_ec_key
    OpenSSL::PKey::EC.generate('prime256v1')
  end

  def ec_public_jwk(pkey)
    # Extract uncompressed EC point from SubjectPublicKeyInfo DER
    asn1        = OpenSSL::ASN1.decode(pkey.public_to_der)
    point_bytes = asn1.value[1].value  # BIT STRING value → 04 || X || Y
    x = point_bytes[1, 32]
    y = point_bytes[33, 32]
    { kty: 'EC', crv: 'P-256',
      x: Base64.urlsafe_encode64(x, padding: false),
      y: Base64.urlsafe_encode64(y, padding: false) }
  end

  def dpop_proof(pkey, htm, htu, access_token: nil, nonce: nil)
    header  = { typ: 'dpop+jwt', alg: 'ES256', jwk: ec_public_jwk(pkey) }
    payload = { jti: SecureRandom.uuid, htm: htm, htu: htu, iat: Time.now.to_i }
    payload[:ath]   = Base64.urlsafe_encode64(Digest::SHA256.digest(access_token), padding: false) if access_token
    payload[:nonce] = nonce if nonce

    h = Base64.urlsafe_encode64(JSON.generate(header),  padding: false)
    p = Base64.urlsafe_encode64(JSON.generate(payload), padding: false)
    signing_input = "#{h}.#{p}"

    der_sig = pkey.sign(OpenSSL::Digest::SHA256.new, signing_input)
    raw_sig = der_to_raw_ec_sig(der_sig)
    "#{signing_input}.#{Base64.urlsafe_encode64(raw_sig, padding: false)}"
  end

  private

  def der_to_raw_ec_sig(der_sig, len = 32)
    asn1 = OpenSSL::ASN1.decode(der_sig)
    [asn1.value[0].value, asn1.value[1].value].map do |v|
      # Ruby 4.0 / newer openssl gem: INTEGER values are OpenSSL::BN, not String
      b = v.is_a?(OpenSSL::BN) ? v.to_s(2).b : v.b
      b = b[1..] while b.bytesize > len && b.getbyte(0) == 0
      ("\x00".b * [len - b.bytesize, 0].max) + b
    end.join
  end
end

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

  # Introspects an access token and asserts it is valid (action == OK).
  def assert_token_valid(sdk, service_id, access_token)
    intro_resp = sdk.introspection.process_request(
      service_id: service_id,
      introspection_request: Authlete::Models::Components::IntrospectionRequest.new(
        token: access_token
      )
    ).introspection_response
    assert_equal 'OK', intro_resp.action.serialize,
      "Expected OK for introspection, got #{intro_resp.action}: #{intro_resp.result_message}"
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

    begin
      resp = sdk_client.clients.create(
        service_id: service_id.to_s,
        client: client_input
      )
    rescue Authlete::Models::Errors::ResultError => e
      raise "Client creation failed [#{e.result_code}]: #{e.result_message}"
    end

    resp.client
  end
end

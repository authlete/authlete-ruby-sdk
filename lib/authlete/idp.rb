# frozen_string_literal: true

# IDP URL routing for Authlete::Client.
#
# This file is hand-written, not generated. The gem entry point loads it via
# .speakeasy/patches/lib/authlete_ruby_sdk.rb.patch, which Speakeasy reapplies
# after every generation.
#
# Background
# ----------
# Authlete runs two API surfaces:
#
#   - Main API (us.authlete.com, jp.authlete.com, ...): OAuth/OIDC runtime
#   - IDP (login.authlete.com): service lifecycle, audit logs
#
# The OpenAPI spec gives IDP operations their own server, so the generated
# SDK already sends them to https://login.authlete.com. What it cannot do is
# let DC/self-managed customers point those operations at their own IDP once
# for the whole client, or fill in the apiServerId (cluster ID) that service
# create and remove require.
#
# This adds both through a Faraday middleware that matches requests by URL
# origin, so it does not depend on generated internals.

require 'json'
require 'uri'
require 'faraday'

module Authlete
  module IdpRouting
    # API server IDs of the Authlete SaaS clusters, keyed by cluster origin.
    # Used to fill in apiServerId for service create and remove, so SaaS
    # customers never need to know cluster IDs. DC/self-managed customers
    # pass api_server_id explicitly, since a custom domain cannot be mapped.
    SAAS_CLUSTER_IDS = {
      'https://us.authlete.com' => 76_281,
      'https://jp.authlete.com' => 53_285,
      'https://eu.authlete.com' => 63_294,
      'https://br.authlete.com' => 47_363
    }.freeze

    # IDP operations that take apiServerId in their JSON body.
    API_SERVER_ID_PATHS = ['/api/service', '/api/service/remove'].freeze

    # The IDP URL from the spec, read from generated code so this stays in
    # sync with the spec.
    def self.default_idp_origin
      @default_idp_origin ||= origin_of(
        URI(Services::SERVICE_CREATE_IDP_API_SERVERS[Services::SERVICE_CREATE_IDP_API_SERVERS_IDP])
      )
    end

    def self.origin_of(uri)
      default_port = uri.scheme == 'https' ? 443 : 80
      port = uri.port.nil? || uri.port == default_port ? '' : ":#{uri.port}"
      "#{uri.scheme}://#{uri.host}#{port}"
    end

    # Origin plus path prefix, without a trailing slash, so an IDP behind a
    # gateway path (https://gateway.example.com/authlete-idp) routes
    # correctly. Query and fragment are not part of a base URL and are dropped.
    def self.normalize_idp_base(idp_url)
      uri = begin
        URI(idp_url)
      rescue URI::InvalidURIError
        nil
      end
      raise ArgumentError, "idp_url must be an http(s) URL, got #{idp_url.inspect}" unless uri.is_a?(URI::HTTP) && uri.host

      origin_of(uri) + uri.path.sub(%r{/+\z}, '')
    end

    # Installs routing on the client's connection when there is anything to
    # do. The middleware goes on a private copy of the connection, so a
    # Faraday connection shared between clients is never modified.
    def self.install(config, idp_url:, api_server_id:)
      idp_base = idp_url.nil? ? nil : normalize_idp_base(idp_url)

      # Derive the SaaS cluster ID only while the IDP is the default. A custom
      # idp_url means a DC/self-managed deployment, where SaaS cluster IDs are
      # meaningless, so nothing is filled in unless api_server_id is set.
      uses_default_idp = idp_base.nil? || idp_base == default_idp_origin
      api_server_id ||= SAAS_CLUSTER_IDS[main_origin(config)] if uses_default_idp

      return if (idp_base.nil? || idp_base == default_idp_origin) && api_server_id.nil?

      connection = config.client.dup
      connection.builder.insert(0, Middleware, idp_base: idp_base, api_server_id: api_server_id)
      config.client = connection
    end

    def self.main_origin(config)
      origin_of(URI(config.get_server_details.first))
    rescue URI::InvalidURIError
      nil
    end

    class Middleware < Faraday::Middleware
      def initialize(app, idp_base:, api_server_id:)
        super(app)
        @idp_base = idp_base
        @api_server_id = api_server_id
      end

      def on_request(env)
        url = env.url
        # Only requests to the spec-defined IDP origin are touched. A per-call
        # server_url override produces a different origin and passes through.
        return unless IdpRouting.origin_of(url) == IdpRouting.default_idp_origin

        inject_api_server_id(env) if needs_api_server_id?(env, url)

        return if @idp_base.nil? || @idp_base == IdpRouting.default_idp_origin

        env.url = URI(@idp_base + url.path + (url.query ? "?#{url.query}" : ''))
      end

      private

      def needs_api_server_id?(env, url)
        !@api_server_id.nil? &&
          env.method == :post &&
          API_SERVER_ID_PATHS.include?(url.path) &&
          env.body.is_a?(String) &&
          env.request_headers['Content-Type'].to_s.include?('application/json')
      end

      # Fills in apiServerId unless the caller already provided one.
      def inject_api_server_id(env)
        body = JSON.parse(env.body)
        return unless body.is_a?(Hash) && body['apiServerId'].nil?

        body['apiServerId'] = @api_server_id
        env.body = JSON.generate(body)
      rescue JSON::ParserError
        nil
      end
    end

    # Adds idp_url: and api_server_id: to Authlete::Client.new.
    #
    #   # SaaS: nothing to set; apiServerId is derived from server_url
    #   Authlete::Client.new(bearer: token, server_url: 'https://jp.authlete.com')
    #
    #   # DC / self-managed
    #   Authlete::Client.new(
    #     bearer: token,
    #     server_url: 'https://authlete.example.com',
    #     idp_url: 'https://authlete-login.example.com',
    #     api_server_id: 99_999
    #   )
    module ClientOptions
      def initialize(idp_url: nil, api_server_id: nil, **options)
        super(**options)
        IdpRouting.install(@sdk_configuration, idp_url: idp_url, api_server_id: api_server_id)
      end
    end
  end

  Client.prepend(IdpRouting::ClientOptions)
end

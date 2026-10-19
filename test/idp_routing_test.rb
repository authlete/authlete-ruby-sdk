# frozen_string_literal: true

# Tests for lib/authlete/idp.rb (IDP URL routing). No network: every client
# uses a Faraday test adapter that records requests.

require 'minitest/autorun'
require 'json'
require 'faraday'
require_relative '../lib/authlete_ruby_sdk'

class IdpRoutingTest < Minitest::Test
  M = Authlete::Models::Components

  Captured = Struct.new(:http_method, :url, :body, :headers)

  def setup
    @captured = []
  end

  # A Faraday connection whose adapter records each request and returns a
  # response the generated SDK accepts.
  def recording_connection(&extra)
    captured = @captured
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      handler = lambda do |env|
        captured << Captured.new(env.method, env.url.to_s, env.body, env.request_headers.dup)
        status = env.url.path.end_with?('/api/service/remove') ? 204 : 200
        body = status == 204 ? '' : '{"apiKey": 1, "serviceName": "x", "entries": []}'
        [status, { 'Content-Type' => 'application/json' }, body]
      end
      %i[get post put delete].each { |m| stub.public_send(m, /.*/, &handler) }
    end
    Faraday.new do |f|
      extra&.call(f)
      f.adapter :test, stubs
    end
  end

  def client(**options)
    Authlete::Client.new(bearer: 'token', client: recording_connection, **options)
  end

  def create_service(sdk, **body)
    sdk.services.create(request: M::ServiceCreateIdpRequest.new(organization_id: 1, **body))
  end

  def remove_service(sdk, **body)
    sdk.services.remove(request: M::ServiceRemoveIdpRequest.new(organization_id: 1, service_id: 42, **body))
  end

  def last
    @captured.last
  end

  def last_json
    JSON.parse(last.body)
  end

  # --- Loading ------------------------------------------------------------

  def test_loaded_by_the_gem_entry_point
    assert_includes Authlete::Client.ancestors, Authlete::IdpRouting::ClientOptions
  end

  def test_default_idp_origin_comes_from_generated_code
    assert_equal 'https://login.authlete.com', Authlete::IdpRouting.default_idp_origin
  end

  # --- SaaS: apiServerId derived from server_url ---------------------------

  def test_default_server_derives_us_cluster
    create_service(client)
    assert_equal 'https://login.authlete.com/api/service', last.url
    assert_equal 76_281, last_json['apiServerId']
  end

  def test_each_saas_cluster_derives_its_id
    {
      'https://us.authlete.com' => 76_281,
      'https://jp.authlete.com' => 53_285,
      'https://eu.authlete.com' => 63_294,
      'https://br.authlete.com' => 47_363
    }.each do |server_url, id|
      create_service(client(server_url: server_url))
      assert_equal id, last_json['apiServerId'], server_url
    end
  end

  def test_server_url_with_trailing_slash_derives
    create_service(client(server_url: 'https://jp.authlete.com/'))
    assert_equal 53_285, last_json['apiServerId']
  end

  def test_server_idx_derives
    create_service(client(server_idx: 1))
    assert_equal 53_285, last_json['apiServerId']
  end

  def test_remove_gets_api_server_id_too
    remove_service(client(server_url: 'https://eu.authlete.com'))
    assert_equal 'https://login.authlete.com/api/service/remove', last.url
    assert_equal 63_294, last_json['apiServerId']
    assert_equal 42, last_json['serviceId']
  end

  def test_explicit_api_server_id_wins_over_derivation
    create_service(client(server_url: 'https://jp.authlete.com', api_server_id: 12_345))
    assert_equal 12_345, last_json['apiServerId']
  end

  def test_api_server_id_in_the_request_is_never_overwritten
    create_service(client(server_url: 'https://jp.authlete.com'), api_server_id: 99)
    assert_equal 99, last_json['apiServerId']
  end

  def test_unknown_server_with_default_idp_injects_nothing
    create_service(client(server_url: 'https://authlete.example.com'))
    assert_equal 'https://login.authlete.com/api/service', last.url
    refute last_json.key?('apiServerId')
  end

  def test_audit_is_routed_but_gets_no_body
    sdk = client(idp_url: 'https://idp.example.com')
    sdk.audit.get(request: Authlete::Models::Operations::AuditEntriesGetIdpApiRequest.new)
    assert_match %r{\Ahttps://idp\.example\.com/api/audit/entries}, last.url
    assert_nil last.body
  end

  # --- DC / self-managed: custom idp_url -----------------------------------

  def test_custom_idp_url_reroutes_idp_requests
    create_service(client(server_url: 'https://authlete.example.com',
                          idp_url: 'https://idp.example.com', api_server_id: 7))
    assert_equal 'https://idp.example.com/api/service', last.url
    assert_equal 7, last_json['apiServerId']
  end

  def test_custom_idp_url_disables_derivation
    create_service(client(server_url: 'https://jp.authlete.com', idp_url: 'https://idp.example.com'))
    assert_equal 'https://idp.example.com/api/service', last.url
    refute last_json.key?('apiServerId'), 'SaaS cluster ID must not be sent to a custom IDP'
  end

  def test_idp_url_path_prefix_is_kept
    remove_service(client(idp_url: 'https://gw.example.com/authlete-idp/', api_server_id: 7))
    assert_equal 'https://gw.example.com/authlete-idp/api/service/remove', last.url
  end

  def test_idp_url_with_port_and_http
    create_service(client(idp_url: 'http://localhost:8787', api_server_id: 7))
    assert_equal 'http://localhost:8787/api/service', last.url
  end

  def test_idp_url_query_and_fragment_are_dropped
    create_service(client(idp_url: 'https://idp.example.com/base?x=1#y', api_server_id: 7))
    assert_equal 'https://idp.example.com/base/api/service', last.url
  end

  def test_explicit_default_idp_url_still_derives
    create_service(client(server_url: 'https://br.authlete.com', idp_url: 'https://login.authlete.com/'))
    assert_equal 'https://login.authlete.com/api/service', last.url
    assert_equal 47_363, last_json['apiServerId']
  end

  def test_invalid_idp_url_raises
    assert_raises(ArgumentError) { client(idp_url: 'not a url') }
    assert_raises(ArgumentError) { client(idp_url: 'ftp://idp.example.com') }
  end

  # --- Main API requests are untouched ------------------------------------

  def test_main_api_requests_pass_through
    sdk = client(server_url: 'https://jp.authlete.com', idp_url: 'https://idp.example.com',
                 api_server_id: 7, service_id: '123')
    sdk.services.retrieve
    assert_equal 'https://jp.authlete.com/api/123/service/get', last.url
  end

  def test_main_api_request_is_identical_with_and_without_idp_options
    plain = client(server_url: 'https://jp.authlete.com', service_id: '123')
    routed = client(server_url: 'https://jp.authlete.com', service_id: '123',
                    idp_url: 'https://idp.example.com', api_server_id: 7)
    request = M::IntrospectionRequest.new(token: 'abc')
    [plain, routed].each { |sdk| sdk.introspection.process_request(introspection_request: request) }
    a, b = @captured.last(2)
    assert_equal [a.http_method, a.url, a.body], [b.http_method, b.url, b.body]
    without_agent = ->(h) { h.reject { |k, _| k == 'User-Agent' } }
    assert_equal without_agent.call(a.headers), without_agent.call(b.headers)
  end

  def test_per_call_server_url_on_idp_operation_passes_through
    sdk = client(idp_url: 'https://idp.example.com', api_server_id: 7)
    sdk.services.create(request: M::ServiceCreateIdpRequest.new(organization_id: 1),
                        server_url: 'https://other.example.com')
    assert_equal 'https://other.example.com/api/service', last.url
    refute last_json.key?('apiServerId')
  end

  def test_nothing_installed_when_there_is_nothing_to_do
    connection = recording_connection
    sdk = Authlete::Client.new(bearer: 'token', client: connection, server_url: 'https://authlete.example.com')
    assert_same connection, sdk.instance_variable_get(:@sdk_configuration).client
  end

  # --- Caller-provided connections ----------------------------------------

  def test_shared_connection_is_not_modified
    shared = recording_connection
    before = shared.builder.handlers.dup
    a = Authlete::Client.new(bearer: 't', client: shared, idp_url: 'https://a.example.com', api_server_id: 1)
    b = Authlete::Client.new(bearer: 't', client: shared, idp_url: 'https://b.example.com', api_server_id: 2)
    c = Authlete::Client.new(bearer: 't', client: shared, server_url: 'https://jp.authlete.com')
    assert_equal before, shared.builder.handlers

    create_service(a)
    assert_equal ['https://a.example.com/api/service', 1], [last.url, last_json['apiServerId']]
    create_service(b)
    assert_equal ['https://b.example.com/api/service', 2], [last.url, last_json['apiServerId']]
    create_service(c)
    assert_equal ['https://login.authlete.com/api/service', 53_285], [last.url, last_json['apiServerId']]
    create_service(a)
    assert_equal ['https://a.example.com/api/service', 1], [last.url, last_json['apiServerId']]
  end

  def test_shared_connection_used_directly_is_unaffected
    shared = recording_connection
    Authlete::Client.new(bearer: 't', client: shared, idp_url: 'https://a.example.com', api_server_id: 1)
    shared.post('https://login.authlete.com/api/service', '{}', 'Content-Type' => 'application/json')
    assert_equal ['https://login.authlete.com/api/service', '{}'], [last.url, last.body]
  end

  def test_callers_own_middleware_still_runs
    connection = recording_connection { |f| f.headers['X-Custom'] = 'yes' }
    sdk = Authlete::Client.new(bearer: 't', client: connection, idp_url: 'https://idp.example.com', api_server_id: 1)
    create_service(sdk)
    assert_equal 'https://idp.example.com/api/service', last.url
    assert_equal 'yes', last.headers['X-Custom']
  end

  def test_works_with_the_default_connection
    sdk = Authlete::Client.new(bearer: 't', idp_url: 'https://idp.example.com', api_server_id: 1)
    handlers = sdk.instance_variable_get(:@sdk_configuration).client.builder.handlers
    assert_equal Authlete::IdpRouting::Middleware, handlers.first.klass
  end

  # --- Together with the service_id global --------------------------------

  def test_service_id_global_and_idp_options_together
    sdk = client(server_url: 'https://jp.authlete.com', service_id: '123')
    sdk.clients.list
    assert_equal 'https://jp.authlete.com/api/123/client/get/list', last.url
    create_service(sdk)
    assert_equal ['https://login.authlete.com/api/service', 53_285], [last.url, last_json['apiServerId']]
    refute last_json.key?('serviceId'), 'service_id global must not leak into IDP bodies'
  end

  # --- Retries, concurrency, misuse ----------------------------------------

  def test_retried_request_keeps_routing_and_injects_once
    attempts = []
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.post(/.*/) do |env|
        attempts << [env.url.to_s, env.body]
        attempts.size < 3 ? [503, { 'Content-Type' => 'application/json' }, '{}'] : [200, { 'Content-Type' => 'application/json' }, '{"apiKey": 1}']
      end
    end
    connection = Faraday.new { |f| f.adapter :test, stubs }
    retry_config = Authlete::Utils::RetryConfig.new(
      backoff: Authlete::Utils::BackoffStrategy.new(initial_interval: 1, max_interval: 2, exponent: 1.1, max_elapsed_time: 5000),
      retry_connection_errors: true, strategy: 'backoff'
    )
    sdk = Authlete::Client.new(bearer: 't', client: connection, idp_url: 'https://idp.example.com',
                               api_server_id: 7, retry_config: retry_config)
    sdk.services.create(request: M::ServiceCreateIdpRequest.new(organization_id: 1), retries: retry_config)
    assert_equal 3, attempts.size
    attempts.each do |url, body|
      assert_equal 'https://idp.example.com/api/service', url
      assert_equal({ 'organizationId' => 1, 'apiServerId' => 7 }, JSON.parse(body))
    end
  end

  def test_concurrent_clients_on_one_connection_do_not_cross_talk
    shared = recording_connection
    clients = {
      'https://a.example.com/api/service' => [Authlete::Client.new(bearer: 't', client: shared, idp_url: 'https://a.example.com', api_server_id: 1), 1],
      'https://b.example.com/api/service' => [Authlete::Client.new(bearer: 't', client: shared, idp_url: 'https://b.example.com', api_server_id: 2), 2],
      'https://login.authlete.com/api/service' => [Authlete::Client.new(bearer: 't', client: shared, server_url: 'https://eu.authlete.com'), 63_294]
    }
    threads = 30.times.map do |i|
      Thread.new do
        sdk = clients.values[i % 3].first
        20.times { create_service(sdk) }
      end
    end
    threads.each(&:join)
    assert_equal 600, @captured.size
    by_url = @captured.group_by(&:url)
    assert_equal clients.keys.sort, by_url.keys.sort
    by_url.each do |url, reqs|
      assert_equal 200, reqs.size, url
      assert(reqs.all? { |r| JSON.parse(r.body)['apiServerId'] == clients[url][1] }, url)
    end
  end

  def test_misspelled_option_is_still_rejected
    assert_raises(ArgumentError) { Authlete::Client.new(bearer: 't', idp_ur: 'https://idp.example.com') }
  end
end

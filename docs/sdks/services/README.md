# Services
(*services*)

## Overview

### Available Operations

* [retrieve](#retrieve) - Get Service
* [list](#list) - List Services
* [create](#create) - Create Service
* [update](#update) - Update Service
* [destroy](#destroy) - Delete Service ⚡
* [configuration](#configuration) - Get Service Configuration

## retrieve

Get a service.

If the access token can only view or modify clients underneath this service, but does not
have access to view this service directly, a limited view of the service will be returned.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="service_get_api" method="get" path="/api/{serviceId}/service/get" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.services.retrieve(service_id: '<id>')

unless res.service.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `service_id`       | *::String*         | :heavy_check_mark: | A service ID.      |

### Response

**[T.nilable(Models::Operations::ServiceGetApiResponse)](../../models/operations/servicegetapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list

Get a list of services.

If the access token can only view or modify clients underneath a service, but does not
have access to view that service directly, a limited view of the service will be returned.
Otherwise, all properties of the service are returned.

If the access token is an administrative token, this returns a list of all services on the Authlete instance.
Otherwise, all services that the access token can view, even in a limited fashion, are returned.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="service_get_list_api" method="get" path="/api/service/get/list" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.services.list()

unless res.service_get_list_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `start`                                                                                           | *T.nilable(::Integer)*                                                                            | :heavy_minus_sign:                                                                                | Start index (inclusive) of the result set. The default value is 0. Must not be a negative number. |
| `end_`                                                                                            | *T.nilable(::Integer)*                                                                            | :heavy_minus_sign:                                                                                | End index (exclusive) of the result set. The default value is 5. Must not be a negative number.   |

### Response

**[T.nilable(Models::Operations::ServiceGetListApiResponse)](../../models/operations/servicegetlistapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create a new service.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="service_create_api" method="post" path="/api/service/create" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Components::ServiceInput.new(
  service_name: 'My service',
  issuer: 'https://my-service.example.com',
  client_id_alias_enabled: true,
  supported_grant_types: [
    Models::Components::GrantType::AUTHORIZATION_CODE,
    Models::Components::GrantType::REFRESH_TOKEN,
  ],
  supported_response_types: [
    Models::Components::ResponseType::CODE,
  ],
  authorization_endpoint: 'https://my-service.example.com/authz',
  pkce_required: true,
  token_endpoint: 'https://my-service.example.com/token',
  supported_token_auth_methods: [
    Models::Components::ClientAuthMethod::CLIENT_SECRET_BASIC,
  ],
  revocation_endpoint: 'https://my-service.example.com/revocation',
  supported_revocation_auth_methods: [
    Models::Components::ClientAuthMethod::CLIENT_SECRET_BASIC,
  ],
  introspection_endpoint: 'https://my-service.example.com/introspection',
  supported_introspection_auth_methods: [
    Models::Components::ClientAuthMethod::CLIENT_SECRET_BASIC,
  ],
  access_token_type: 'Bearer',
  access_token_duration: 3600,
  refresh_token_duration: 3600,
  supported_scopes: [
    Models::Components::Scope.new(
      name: 'timeline.read',
      default_entry: false,
      description: 'A permission to read your timeline.',
    ),
    Models::Components::Scope.new(
      name: 'history.read',
      default_entry: false,
      description: 'A permission to read your history.',
    ),
  ],
  attributes: [
    Models::Components::Pair.new(
      key: 'attribute1-key',
      value: 'attribute1-value',
    ),
    Models::Components::Pair.new(
      key: 'attribute2-key',
      value: 'attribute2-value',
    ),
  ],
)

res = s.services.create(request: req)

unless res.service.nil?
  # handle response
end

```

### Parameters

| Parameter                                                               | Type                                                                    | Required                                                                | Description                                                             |
| ----------------------------------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `request`                                                               | [Models::Components::ServiceInput](../../models/shared/serviceinput.md) | :heavy_check_mark:                                                      | The request object to use for the request.                              |

### Response

**[T.nilable(Models::Operations::ServiceCreateApiResponse)](../../models/operations/servicecreateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Update a service.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="service_update_api" method="post" path="/api/{serviceId}/service/update" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.services.update(service_id: '<id>', service: Models::Components::ServiceInput.new(
  service_name: 'My updated service',
  issuer: 'https://my-service.example.com',
  clients_per_developer: 0,
  client_id_alias_enabled: true,
  supported_grant_types: [
    Models::Components::GrantType::AUTHORIZATION_CODE,
    Models::Components::GrantType::REFRESH_TOKEN,
  ],
  supported_response_types: [
    Models::Components::ResponseType::CODE,
  ],
  error_description_omitted: false,
  error_uri_omitted: false,
  authorization_endpoint: 'https://my-service.example.com/authz',
  direct_authorization_endpoint_enabled: false,
  supported_displays: [
    Models::Components::Display::PAGE,
  ],
  pkce_required: true,
  pkce_s256_required: false,
  authorization_response_duration: 0,
  token_endpoint: 'https://my-service.example.com/token',
  direct_token_endpoint_enabled: false,
  supported_token_auth_methods: [
    Models::Components::ClientAuthMethod::CLIENT_SECRET_BASIC,
  ],
  missing_client_id_allowed: false,
  revocation_endpoint: 'https://my-service.example.com/revocation',
  direct_revocation_endpoint_enabled: false,
  supported_revocation_auth_methods: [
    Models::Components::ClientAuthMethod::CLIENT_SECRET_BASIC,
  ],
  introspection_endpoint: 'https://my-service.example.com/introspection',
  direct_introspection_endpoint_enabled: false,
  supported_introspection_auth_methods: [
    Models::Components::ClientAuthMethod::CLIENT_SECRET_BASIC,
  ],
  pushed_auth_req_duration: 0,
  par_required: false,
  request_object_required: false,
  traditional_request_object_processing_applied: false,
  mutual_tls_validate_pki_cert_chain: false,
  access_token_type: 'Bearer',
  tls_client_certificate_bound_access_tokens: false,
  access_token_duration: 3600,
  single_access_token_per_subject: false,
  refresh_token_duration: 3600,
  refresh_token_duration_kept: false,
  refresh_token_duration_reset: false,
  refresh_token_kept: false,
  supported_scopes: [
    Models::Components::Scope.new(
      name: 'history.read',
      default_entry: false,
      description: 'A permission to read your history.',
    ),
    Models::Components::Scope.new(
      name: 'timeline.read',
      default_entry: false,
      description: 'A permission to read your timeline.',
    ),
  ],
  scope_required: false,
  id_token_duration: 0,
  allowable_clock_skew: 0,
  supported_claim_types: [
    Models::Components::ClaimType::NORMAL,
  ],
  claim_shortcut_restrictive: false,
  direct_jwks_endpoint_enabled: false,
  direct_user_info_endpoint_enabled: false,
  dynamic_registration_supported: false,
  backchannel_auth_req_id_duration: 0,
  backchannel_polling_interval: 0,
  backchannel_user_code_parameter_supported: false,
  backchannel_binding_message_required_in_fapi: false,
  device_flow_code_duration: 0,
  device_flow_polling_interval: 0,
  user_code_length: 0,
  attributes: [
    Models::Components::Pair.new(
      key: 'attribute1-key',
      value: 'attribute1-value',
    ),
    Models::Components::Pair.new(
      key: 'attribute2-key',
      value: 'attribute2-value',
    ),
  ],
  nbf_optional: false,
  iss_suppressed: false,
  token_expiration_linked: false,
  front_channel_request_object_encryption_required: false,
  request_object_encryption_alg_match_required: false,
  request_object_encryption_enc_match_required: false,
  hsm_enabled: false,
  grant_management_action_required: false,
  unauthorized_on_client_config_supported: false,
  dcr_scope_used_as_requestable: false,
))

unless res.service.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                               | Type                                                                                                                                                                                                                                                    | Required                                                                                                                                                                                                                                                | Description                                                                                                                                                                                                                                             | Example                                                                                                                                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                                                                                            | *::String*                                                                                                                                                                                                                                              | :heavy_check_mark:                                                                                                                                                                                                                                      | A service ID.                                                                                                                                                                                                                                           |                                                                                                                                                                                                                                                         |
| `service`                                                                                                                                                                                                                                               | [T.nilable(Models::Components::ServiceInput)](../../models/shared/serviceinput.md)                                                                                                                                                                      | :heavy_minus_sign:                                                                                                                                                                                                                                      | N/A                                                                                                                                                                                                                                                     | {<br/>"number": 715948317,<br/>"serviceName": "My Test Service",<br/>"issuer": "https://example.com",<br/>"supportedScopes": [<br/>"profile",<br/>"email",<br/>"openid"<br/>],<br/>"supportedResponseTypes": [<br/>"CODE"<br/>],<br/>"supportedGrantTypes": [<br/>"AUTHORIZATION_CODE",<br/>"REFRESH_TOKEN"<br/>]<br/>} |

### Response

**[T.nilable(Models::Operations::ServiceUpdateApiResponse)](../../models/operations/serviceupdateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## destroy

Delete a service.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="service_delete_api" method="delete" path="/api/{serviceId}/service/delete" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.services.destroy(service_id: '<id>')

if res.status_code == 200
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `service_id`       | *::String*         | :heavy_check_mark: | A service ID.      |

### Response

**[T.nilable(Models::Operations::ServiceDeleteApiResponse)](../../models/operations/servicedeleteapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## configuration

This API gathers configuration information about a service.
### Description
This API is supposed to be called from within the implementation of the configuration endpoint of
the service where the service that supports OpenID Connect and [OpenID Connect Discovery 1.0](https://openid.net/specs/openid-connect-discovery-1\_0.html)
must expose its configuration information in a JSON format. Details about the format are described
in "[3. OpenID Provider Metadata](https://openid.net/specs/openid-connect-discovery-1\_0.html#ProviderMetadata)"
in OpenID Connect Discovery 1.0.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="service_configuration_api" method="get" path="/api/{serviceId}/service/configuration" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.services.configuration(service_id: '<id>')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                        | Type                                                                                                                                                                             | Required                                                                                                                                                                         | Description                                                                                                                                                                      |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                     | *::String*                                                                                                                                                                       | :heavy_check_mark:                                                                                                                                                               | A service ID.                                                                                                                                                                    |
| `pretty`                                                                                                                                                                         | *T.nilable(T::Boolean)*                                                                                                                                                          | :heavy_minus_sign:                                                                                                                                                               | This boolean value indicates whether the JSON in the response should be formatted or not. If `true`, the JSON in the response is pretty-formatted. The default value is `false`. |
| `patch`                                                                                                                                                                          | *T.nilable(::String)*                                                                                                                                                            | :heavy_minus_sign:                                                                                                                                                               | Get the JSON Patch [RFC 6902 JavaScript Object Notation (JSON) Patch](https://www.rfc-editor.org/rfc/rfc6902) to be applied.                                                     |

### Response

**[T.nilable(Models::Operations::ServiceConfigurationApiResponse)](../../models/operations/serviceconfigurationapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
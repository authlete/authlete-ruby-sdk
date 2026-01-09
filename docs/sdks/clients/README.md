# Clients

## Overview

### Available Operations

* [retrieve](#retrieve) - Get Client
* [list](#list) - List Clients
* [create](#create) - Create Client
* [update](#update) - Update Client
* [update_form](#update_form) - Update Client
* [destroy](#destroy) - Delete Client ⚡

## retrieve

Get a client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_get_api" method="get" path="/api/{serviceId}/client/get/{clientId}" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.clients.retrieve(service_id: '<id>', client_id: '<id>')

unless res.client.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `service_id`       | *::String*         | :heavy_check_mark: | A service ID.      |
| `client_id`        | *::String*         | :heavy_check_mark: | A client ID.       |

### Response

**[T.nilable(Models::Operations::ClientGetApiResponse)](../../models/operations/clientgetapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list

Get a list of clients on a service.

If the access token can view a full service (including an admin), all clients within the
service are returned. Otherwise, only clients that the access token can view within the
service are returned.
- ViewClient: []


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_get_list_api" method="get" path="/api/{serviceId}/client/get/list" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.clients.list(service_id: '<id>')

unless res.client_get_list_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                         | Type                                                                                                                                                                                                                                              | Required                                                                                                                                                                                                                                          | Description                                                                                                                                                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                                                                                      | *::String*                                                                                                                                                                                                                                        | :heavy_check_mark:                                                                                                                                                                                                                                | A service ID.                                                                                                                                                                                                                                     |
| `developer`                                                                                                                                                                                                                                       | *T.nilable(::String)*                                                                                                                                                                                                                             | :heavy_minus_sign:                                                                                                                                                                                                                                | The developer of client applications. The default value is null. If this parameter is not set<br/>to `null`, client application of the specified developer are returned. Otherwise, all client<br/>applications that belong to the service are returned.<br/> |
| `start`                                                                                                                                                                                                                                           | *T.nilable(::Integer)*                                                                                                                                                                                                                            | :heavy_minus_sign:                                                                                                                                                                                                                                | Start index (inclusive) of the result set. The default value is 0. Must not be a negative number.                                                                                                                                                 |
| `end_`                                                                                                                                                                                                                                            | *T.nilable(::Integer)*                                                                                                                                                                                                                            | :heavy_minus_sign:                                                                                                                                                                                                                                | End index (exclusive) of the result set. The default value is 5. Must not be a negative number.                                                                                                                                                   |

### Response

**[T.nilable(Models::Operations::ClientGetListApiResponse)](../../models/operations/clientgetlistapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create a new client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_create_api" method="post" path="/api/{serviceId}/client/create" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.clients.create(service_id: '<id>', client: Models::Components::ClientInput.new(
  client_name: 'My Client',
  client_id_alias: 'my-client',
  client_id_alias_enabled: true,
  client_type: Models::Components::ClientType::CONFIDENTIAL,
  application_type: Models::Components::ApplicationType::WEB,
  developer: 'john',
  grant_types: [
    Models::Components::GrantType::AUTHORIZATION_CODE,
    Models::Components::GrantType::REFRESH_TOKEN,
  ],
  response_types: [
    Models::Components::ResponseType::CODE,
    Models::Components::ResponseType::TOKEN,
  ],
  redirect_uris: [
    'https://my-client.example.com/cb1',
    'https://my-client.example.com/cb2',
  ],
  token_auth_method: Models::Components::ClientAuthMethod::CLIENT_SECRET_BASIC,
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
))

unless res.client.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                 | Type                                                                                                                                                                                                                                                                                                                                                                      | Required                                                                                                                                                                                                                                                                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                               | Example                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                                                                                                                                                                                                              | *::String*                                                                                                                                                                                                                                                                                                                                                                | :heavy_check_mark:                                                                                                                                                                                                                                                                                                                                                        | A service ID.                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                           |
| `client`                                                                                                                                                                                                                                                                                                                                                                  | [T.nilable(Models::Components::ClientInput)](../../models/shared/clientinput.md)                                                                                                                                                                                                                                                                                          | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                        | N/A                                                                                                                                                                                                                                                                                                                                                                       | {<br/>"number": 1140735077,<br/>"serviceNumber": 715948317,<br/>"clientName": "My Test Client",<br/>"clientId": "1140735077",<br/>"clientSecret": "gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ",<br/>"clientType": "PUBLIC",<br/>"redirectUris": [<br/>"https://example.com/callback"<br/>],<br/>"responseTypes": [<br/>"CODE"<br/>],<br/>"grantTypes": [<br/>"AUTHORIZATION_CODE"<br/>]<br/>} |

### Response

**[T.nilable(Models::Operations::ClientCreateApiResponse)](../../models/operations/clientcreateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Update a client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_update_api" method="post" path="/api/{serviceId}/client/update/{clientId}" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.clients.update(service_id: '<id>', client_id: '<id>', client: Models::Components::ClientInput.new(
  client_name: 'My updated client',
  client_id_alias: 'my-client',
  client_id_alias_enabled: true,
  client_type: Models::Components::ClientType::CONFIDENTIAL,
  application_type: Models::Components::ApplicationType::WEB,
  tls_client_certificate_bound_access_tokens: false,
  developer: 'john',
  grant_types: [
    Models::Components::GrantType::AUTHORIZATION_CODE,
    Models::Components::GrantType::REFRESH_TOKEN,
  ],
  response_types: [
    Models::Components::ResponseType::CODE,
    Models::Components::ResponseType::TOKEN,
  ],
  redirect_uris: [
    'https://my-client.example.com/cb1',
    'https://my-client.example.com/cb2',
  ],
  token_auth_method: Models::Components::ClientAuthMethod::CLIENT_SECRET_BASIC,
  par_required: false,
  request_object_required: false,
  default_max_age: 0,
  id_token_sign_alg: Models::Components::JwsAlg::RS256,
  auth_time_required: false,
  subject_type: Models::Components::SubjectType::PUBLIC,
  bc_user_code_required: false,
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
  front_channel_request_object_encryption_required: false,
  request_object_encryption_alg_match_required: false,
  request_object_encryption_enc_match_required: false,
  additional_properties: {
    "derivedSectorIdentifier": 'my-client.example.com',
    "dynamicallyRegistered": false,
  },
))

unless res.client.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                 | Type                                                                                                                                                                                                                                                                                                                                                                      | Required                                                                                                                                                                                                                                                                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                               | Example                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                                                                                                                                                                                                              | *::String*                                                                                                                                                                                                                                                                                                                                                                | :heavy_check_mark:                                                                                                                                                                                                                                                                                                                                                        | A service ID.                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                           |
| `client_id`                                                                                                                                                                                                                                                                                                                                                               | *::String*                                                                                                                                                                                                                                                                                                                                                                | :heavy_check_mark:                                                                                                                                                                                                                                                                                                                                                        | A client ID.                                                                                                                                                                                                                                                                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                           |
| `client`                                                                                                                                                                                                                                                                                                                                                                  | [T.nilable(Models::Components::ClientInput)](../../models/shared/clientinput.md)                                                                                                                                                                                                                                                                                          | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                        | N/A                                                                                                                                                                                                                                                                                                                                                                       | {<br/>"number": 1140735077,<br/>"serviceNumber": 715948317,<br/>"clientName": "My Test Client",<br/>"clientId": "1140735077",<br/>"clientSecret": "gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ",<br/>"clientType": "PUBLIC",<br/>"redirectUris": [<br/>"https://example.com/callback"<br/>],<br/>"responseTypes": [<br/>"CODE"<br/>],<br/>"grantTypes": [<br/>"AUTHORIZATION_CODE"<br/>]<br/>} |

### Response

**[T.nilable(Models::Operations::ClientUpdateApiResponse)](../../models/operations/clientupdateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update_form

Update a client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_update_api_form" method="post" path="/api/{serviceId}/client/update/{clientId}" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.clients.update_form(service_id: '<id>', client_id: '<id>', request_body: {
  "clientName": 'My Test Client',
  "clientType": 'PUBLIC',
  "grantTypes": [
    'AUTHORIZATION_CODE',
  ],
  "responseTypes": [
    'CODE',
  ],
  "redirectUris": [
    'https://example.com/callback',
  ],
  "number": 1_140_735_077,
  "serviceNumber": 715_948_317,
  "clientId": '1140735077',
  "clientSecret": 'gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ',
})

unless res.client.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                 | Type                                                                                                                                                                                                                                                                                                                                                                      | Required                                                                                                                                                                                                                                                                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                               | Example                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                                                                                                                                                                                                              | *::String*                                                                                                                                                                                                                                                                                                                                                                | :heavy_check_mark:                                                                                                                                                                                                                                                                                                                                                        | A service ID.                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                           |
| `client_id`                                                                                                                                                                                                                                                                                                                                                               | *::String*                                                                                                                                                                                                                                                                                                                                                                | :heavy_check_mark:                                                                                                                                                                                                                                                                                                                                                        | A client ID.                                                                                                                                                                                                                                                                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                           |
| `request_body`                                                                                                                                                                                                                                                                                                                                                            | T::Hash[Symbol, *::Object*]                                                                                                                                                                                                                                                                                                                                               | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                        | N/A                                                                                                                                                                                                                                                                                                                                                                       | {<br/>"number": 1140735077,<br/>"serviceNumber": 715948317,<br/>"clientName": "My Test Client",<br/>"clientId": "1140735077",<br/>"clientSecret": "gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ",<br/>"clientType": "PUBLIC",<br/>"redirectUris": [<br/>"https://example.com/callback"<br/>],<br/>"responseTypes": [<br/>"CODE"<br/>],<br/>"grantTypes": [<br/>"AUTHORIZATION_CODE"<br/>]<br/>} |

### Response

**[T.nilable(Models::Operations::ClientUpdateApiFormResponse)](../../models/operations/clientupdateapiformresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## destroy

Delete a client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_delete_api" method="delete" path="/api/{serviceId}/client/delete/{clientId}" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.clients.destroy(service_id: '<id>', client_id: '<id>')

if res.status_code == 200
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `service_id`       | *::String*         | :heavy_check_mark: | A service ID.      |
| `client_id`        | *::String*         | :heavy_check_mark: | The client ID.     |

### Response

**[T.nilable(Models::Operations::ClientDeleteApiResponse)](../../models/operations/clientdeleteapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
# Clients

## Overview

### Available Operations

* [retrieve](#retrieve) - Get Client
* [list](#list) - List Clients
* [create](#create) - Create Client
* [update](#update) - Update Client
* [update_form](#update_form) - Update Client
* [destroy](#destroy) - Delete Client ⚡
* [list_by_cursor](#list_by_cursor) - List Clients (Cursor Pagination)
* [search](#search) - Search Clients

## retrieve

Get a client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_get_api" method="get" path="/api/{serviceId}/client/get/{clientId}" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.clients.retrieve(client_id: '<id>')

unless res.client.nil?
  # handle response
end

```

### Parameters

| Parameter             | Type                  | Required              | Description           |
| --------------------- | --------------------- | --------------------- | --------------------- |
| `client_id`           | *::String*            | :heavy_check_mark:    | A client ID.          |
| `service_id`          | *T.nilable(::String)* | :heavy_minus_sign:    | A service ID.         |

### Response

**[T.nilable(Models::Operations::ClientGetApiResponse)](../../models/operations/clientgetapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403, 404          | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list

Get a list of clients on a service.

If the access token can view a full service (including an admin), all clients within the service are returned. Otherwise, only clients that the access token can view within the service are returned.
- ViewClient: []


### Example Usage: full

<!-- UsageSnippet language="ruby" operationID="client_get_list_api" method="get" path="/api/{serviceId}/client/get/list" example="full" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.clients.list

unless res.client_get_list_response.nil?
  # handle response
end

```
### Example Usage: limited

<!-- UsageSnippet language="ruby" operationID="client_get_list_api" method="get" path="/api/{serviceId}/client/get/list" example="limited" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.clients.list

unless res.client_get_list_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                         | Type                                                                                                                                                                                                                                              | Required                                                                                                                                                                                                                                          | Description                                                                                                                                                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                                                                                      | *T.nilable(::String)*                                                                                                                                                                                                                             | :heavy_minus_sign:                                                                                                                                                                                                                                | A service ID.                                                                                                                                                                                                                                     |
| `developer`                                                                                                                                                                                                                                       | *T.nilable(::String)*                                                                                                                                                                                                                             | :heavy_minus_sign:                                                                                                                                                                                                                                | The developer of client applications. The default value is null. If this parameter is not set to `null`, client application of the specified developer are returned. Otherwise, all client applications that belong to the service are returned.<br/> |
| `start`                                                                                                                                                                                                                                           | *T.nilable(::Integer)*                                                                                                                                                                                                                            | :heavy_minus_sign:                                                                                                                                                                                                                                | Start index (inclusive) of the result set. The default value is 0. Must not be a negative number.                                                                                                                                                 |
| `end_`                                                                                                                                                                                                                                            | *T.nilable(::Integer)*                                                                                                                                                                                                                            | :heavy_minus_sign:                                                                                                                                                                                                                                | End index (exclusive) of the result set. The default value is 5. Must not be a negative number.                                                                                                                                                   |

### Response

**[T.nilable(Models::Operations::ClientGetListApiResponse)](../../models/operations/clientgetlistapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create a new client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_create_api" method="post" path="/api/{serviceId}/client/create" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.clients.create(client: Models::Components::ClientInput.new(
  client_name: 'My Client',
  client_id_alias: 'my-client',
  client_type: Models::Components::ClientType::CONFIDENTIAL,
  application_type: Models::Components::ApplicationType::WEB,
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
      value: 'attribute1-value'
    ),
    Models::Components::Pair.new(
      key: 'attribute2-key',
      value: 'attribute2-value'
    ),
  ]
))

unless res.client.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                 | Type                                                                                                                                                                                                                                                                                                                                                                      | Required                                                                                                                                                                                                                                                                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                               | Example                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                                                                                                                                                                                                              | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                                                                     | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                        | A service ID.                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                           |
| `client`                                                                                                                                                                                                                                                                                                                                                                  | [T.nilable(Models::Components::ClientInput)](../../models/shared/clientinput.md)                                                                                                                                                                                                                                                                                          | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                        | N/A                                                                                                                                                                                                                                                                                                                                                                       | {<br/>"number": 1140735077,<br/>"serviceNumber": 715948317,<br/>"clientName": "My Test Client",<br/>"clientId": "1140735077",<br/>"clientSecret": "gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ",<br/>"clientType": "PUBLIC",<br/>"redirectUris": [<br/>"https://example.com/callback"<br/>],<br/>"responseTypes": [<br/>"CODE"<br/>],<br/>"grantTypes": [<br/>"AUTHORIZATION_CODE"<br/>]<br/>} |

### Response

**[T.nilable(Models::Operations::ClientCreateApiResponse)](../../models/operations/clientcreateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Update a client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_update_api" method="post" path="/api/{serviceId}/client/update/{clientId}" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.clients.update(client_id: '<id>', client: Models::Components::ClientInput.new(
  client_name: 'My updated client',
  client_id_alias: 'my-client',
  client_type: Models::Components::ClientType::CONFIDENTIAL,
  application_type: Models::Components::ApplicationType::WEB,
  tls_client_certificate_bound_access_tokens: false,
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
      value: 'attribute1-value'
    ),
    Models::Components::Pair.new(
      key: 'attribute2-key',
      value: 'attribute2-value'
    ),
  ],
  front_channel_request_object_encryption_required: false,
  request_object_encryption_alg_match_required: false,
  request_object_encryption_enc_match_required: false,
  additional_properties: {
    'derivedSectorIdentifier' => 'my-client.example.com',
    'dynamicallyRegistered' => false,
  }
))

unless res.client.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                 | Type                                                                                                                                                                                                                                                                                                                                                                      | Required                                                                                                                                                                                                                                                                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                               | Example                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `client_id`                                                                                                                                                                                                                                                                                                                                                               | *::String*                                                                                                                                                                                                                                                                                                                                                                | :heavy_check_mark:                                                                                                                                                                                                                                                                                                                                                        | A client ID.                                                                                                                                                                                                                                                                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                           |
| `service_id`                                                                                                                                                                                                                                                                                                                                                              | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                                                                     | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                        | A service ID.                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                           |
| `client`                                                                                                                                                                                                                                                                                                                                                                  | [T.nilable(Models::Components::ClientInput)](../../models/shared/clientinput.md)                                                                                                                                                                                                                                                                                          | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                        | N/A                                                                                                                                                                                                                                                                                                                                                                       | {<br/>"number": 1140735077,<br/>"serviceNumber": 715948317,<br/>"clientName": "My Test Client",<br/>"clientId": "1140735077",<br/>"clientSecret": "gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ",<br/>"clientType": "PUBLIC",<br/>"redirectUris": [<br/>"https://example.com/callback"<br/>],<br/>"responseTypes": [<br/>"CODE"<br/>],<br/>"grantTypes": [<br/>"AUTHORIZATION_CODE"<br/>]<br/>} |

### Response

**[T.nilable(Models::Operations::ClientUpdateApiResponse)](../../models/operations/clientupdateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update_form

Update a client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_update_api_form" method="post" path="/api/{serviceId}/client/update/{clientId}" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.clients.update_form(client_id: '<id>', request_body: {
  'clientId' => '1140735077',
  'clientName' => 'My Test Client',
  'clientSecret' => 'gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ',
  'clientType' => 'PUBLIC',
  'grantTypes' => [
    'AUTHORIZATION_CODE',
  ],
  'number' => 1_140_735_077,
  'redirectUris' => [
    'https://example.com/callback',
  ],
  'responseTypes' => [
    'CODE',
  ],
  'serviceNumber' => 715_948_317,
})

unless res.client.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                 | Type                                                                                                                                                                                                                                                                                                                                                                      | Required                                                                                                                                                                                                                                                                                                                                                                  | Description                                                                                                                                                                                                                                                                                                                                                               | Example                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `client_id`                                                                                                                                                                                                                                                                                                                                                               | *::String*                                                                                                                                                                                                                                                                                                                                                                | :heavy_check_mark:                                                                                                                                                                                                                                                                                                                                                        | A client ID.                                                                                                                                                                                                                                                                                                                                                              |                                                                                                                                                                                                                                                                                                                                                                           |
| `service_id`                                                                                                                                                                                                                                                                                                                                                              | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                                                                     | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                        | A service ID.                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                           |
| `request_body`                                                                                                                                                                                                                                                                                                                                                            | T::Hash[Symbol, *::Object*]                                                                                                                                                                                                                                                                                                                                               | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                        | N/A                                                                                                                                                                                                                                                                                                                                                                       | {<br/>"number": 1140735077,<br/>"serviceNumber": 715948317,<br/>"clientName": "My Test Client",<br/>"clientId": "1140735077",<br/>"clientSecret": "gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ",<br/>"clientType": "PUBLIC",<br/>"redirectUris": [<br/>"https://example.com/callback"<br/>],<br/>"responseTypes": [<br/>"CODE"<br/>],<br/>"grantTypes": [<br/>"AUTHORIZATION_CODE"<br/>]<br/>} |

### Response

**[T.nilable(Models::Operations::ClientUpdateApiFormResponse)](../../models/operations/clientupdateapiformresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## destroy

Delete a client.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_delete_api" method="delete" path="/api/{serviceId}/client/delete/{clientId}" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.clients.destroy(client_id: '<id>')

if res.status_code == 200
  # handle response
end

```

### Parameters

| Parameter             | Type                  | Required              | Description           |
| --------------------- | --------------------- | --------------------- | --------------------- |
| `client_id`           | *::String*            | :heavy_check_mark:    | The client ID.        |
| `service_id`          | *T.nilable(::String)* | :heavy_minus_sign:    | A service ID.         |

### Response

**[T.nilable(Models::Operations::ClientDeleteApiResponse)](../../models/operations/clientdeleteapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list_by_cursor

Retrieve the clients in the requested service via cursor based iteration.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_cursor_list_api" method="get" path="/api/{serviceId}/client" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.clients.list_by_cursor

unless res.one_of.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                   | Type                                                                                                                                                                                                                                                        | Required                                                                                                                                                                                                                                                    | Description                                                                                                                                                                                                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                                                                                                | *T.nilable(::String)*                                                                                                                                                                                                                                       | :heavy_minus_sign:                                                                                                                                                                                                                                          | The ID of the service to retrieve a list of clients from.                                                                                                                                                                                                   |
| `cursor`                                                                                                                                                                                                                                                    | *T.nilable(::String)*                                                                                                                                                                                                                                       | :heavy_minus_sign:                                                                                                                                                                                                                                          | This should be set to the value of `nextCursor` from a previous call to this endpoint. Which will retrieve the next set of clients available and receive the next available set. If this is not provided the list operation will start from the beginning.<br/> |
| `limit`                                                                                                                                                                                                                                                     | *T.nilable(::Integer)*                                                                                                                                                                                                                                      | :heavy_minus_sign:                                                                                                                                                                                                                                          | The maximum amount of results to return from this request. This value will be clamped between 1 and the allowed maximum. The default will be used if no value is provided.<br/>                                                                             |
| `include_total_count`                                                                                                                                                                                                                                       | *T.nilable(T::Boolean)*                                                                                                                                                                                                                                     | :heavy_minus_sign:                                                                                                                                                                                                                                          | Indicates whether the `totalCount` property should be calculated and included in the response, otherwise it will be unset. For some large datasets this can be expensive and is not always required to calculate.<br/>                                      |

### Response

**[T.nilable(Models::Operations::ClientCursorListApiResponse)](../../models/operations/clientcursorlistapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## search

Search the clients in the requested service that match the condition provided in the `q` query parameter. Results are returned via cursor based iteration. To iterate through all clients without a search condition, use the `/api/&#123;serviceId&#125;/client` API instead.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_search_api" method="get" path="/api/{serviceId}/client/search" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::ClientSearchApiRequest.new
res = s.clients.search(request: req)

unless res.one_of.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                       | Type                                                                                            | Required                                                                                        | Description                                                                                     |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `request`                                                                                       | [Models::Operations::ClientSearchApiRequest](../../models/operations/clientsearchapirequest.md) | :heavy_check_mark:                                                                              | The request object to use for the request.                                                      |

### Response

**[T.nilable(Models::Operations::ClientSearchApiResponse)](../../models/operations/clientsearchapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
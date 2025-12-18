# TokenManagement
(*token.management*)

## Overview

### Available Operations

* [reissue_id_token](#reissue_id_token) - Reissue ID Token
* [list](#list) - List Issued Tokens
* [create](#create) - Create Access Token
* [update](#update) - Update Access Token
* [delete](#delete) - Delete Access Token
* [revoke](#revoke) - Revoke Access Token

## reissue_id_token

The API is expected to be called only when the value of the `action`
parameter in a response from the `/auth/token` API is [ID_TOKEN_REISSUABLE](https://authlete.github.io/authlete-java-common/com/authlete/common/dto/TokenResponse.Action.html#ID_TOKEN_REISSUABLE). The purpose
of the `/idtoken/reissue` API is to generate a token response that
includes a new ID token together with a new access token and a refresh
token.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="idtoken_reissue_api" method="post" path="/api/{serviceId}/idtoken/reissue" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.token.management.reissue_id_token(service_id: '<id>')

unless res.idtoken_reissue_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                            | Type                                                                                                 | Required                                                                                             | Description                                                                                          |
| ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                         | *::String*                                                                                           | :heavy_check_mark:                                                                                   | A service ID.                                                                                        |
| `idtoken_reissue_request`                                                                            | [T.nilable(Models::Components::IdtokenReissueRequest)](../../models/shared/idtokenreissuerequest.md) | :heavy_minus_sign:                                                                                   | N/A                                                                                                  |

### Response

**[T.nilable(Models::Operations::IdtokenReissueApiResponse)](../../models/operations/idtokenreissueapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list

Get the list of access tokens that are associated with the service.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_get_list_api" method="get" path="/api/{serviceId}/auth/token/get/list" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

req = Models::Operations::AuthTokenGetListApiRequest.new(
  service_id: '<id>',
)

res = s.token.management.list(request: req)

unless res.token_get_list_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                               | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `request`                                                                                               | [Models::Operations::AuthTokenGetListApiRequest](../../models/operations/authtokengetlistapirequest.md) | :heavy_check_mark:                                                                                      | The request object to use for the request.                                                              |

### Response

**[T.nilable(Models::Operations::AuthTokenGetListApiResponse)](../../models/operations/authtokengetlistapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create

Create an access token.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_create_api" method="post" path="/api/{serviceId}/auth/token/create" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.token.management.create(service_id: '<id>', token_create_request: Models::Components::TokenCreateRequest.new(
  grant_type: Models::Components::GrantType::AUTHORIZATION_CODE,
  client_id: 26_888_344_961_664,
  subject: 'john',
  scopes: [
    'history.read',
    'timeline.read',
  ],
))

unless res.token_create_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `service_id`                                                                        | *::String*                                                                          | :heavy_check_mark:                                                                  | A service ID.                                                                       |
| `token_create_request`                                                              | [Models::Components::TokenCreateRequest](../../models/shared/tokencreaterequest.md) | :heavy_check_mark:                                                                  | N/A                                                                                 |

### Response

**[T.nilable(Models::Operations::AuthTokenCreateApiResponse)](../../models/operations/authtokencreateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Update an access token.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_update_api" method="post" path="/api/{serviceId}/auth/token/update" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.token.management.update(service_id: '<id>', token_update_request: Models::Components::TokenUpdateRequest.new(
  access_token: 'Z5a40U6dWvw2gMoCOAFbZcM85q4HC0Z--0YKD9-Nf6Q',
  scopes: [
    'history.read',
  ],
))

unless res.token_update_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `service_id`                                                                        | *::String*                                                                          | :heavy_check_mark:                                                                  | A service ID.                                                                       |
| `token_update_request`                                                              | [Models::Components::TokenUpdateRequest](../../models/shared/tokenupdaterequest.md) | :heavy_check_mark:                                                                  | N/A                                                                                 |

### Response

**[T.nilable(Models::Operations::AuthTokenUpdateApiResponse)](../../models/operations/authtokenupdateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## delete

Delete an access token.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_delete_api" method="delete" path="/api/{serviceId}/auth/token/delete/{accessTokenIdentifier}" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.token.management.delete(service_id: '<id>', access_token_identifier: '<value>')

if res.status_code == 200
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                  | Type                                                                                                                                       | Required                                                                                                                                   | Description                                                                                                                                |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `service_id`                                                                                                                               | *::String*                                                                                                                                 | :heavy_check_mark:                                                                                                                         | A service ID.                                                                                                                              |
| `access_token_identifier`                                                                                                                  | *::String*                                                                                                                                 | :heavy_check_mark:                                                                                                                         | The identifier of an existing access token. The identifier is the value of the access token<br/>or the value of the hash of the access token.<br/> |

### Response

**[T.nilable(Models::Operations::AuthTokenDeleteApiResponse)](../../models/operations/authtokendeleteapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## revoke

Revoke an access token.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_revoke_api" method="post" path="/api/{serviceId}/auth/token/revoke" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.token.management.revoke(service_id: '<id>', token_revoke_request: Models::Components::TokenRevokeRequest.new(
  access_token_identifier: 'Z5a40U6dWvw2gMoCOAFbZcM85q4HC0Z--0YKD9-Nf6Q',
))

unless res.token_revoke_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `service_id`                                                                        | *::String*                                                                          | :heavy_check_mark:                                                                  | A service ID.                                                                       |
| `token_revoke_request`                                                              | [Models::Components::TokenRevokeRequest](../../models/shared/tokenrevokerequest.md) | :heavy_check_mark:                                                                  | N/A                                                                                 |

### Response

**[T.nilable(Models::Operations::AuthTokenRevokeApiResponse)](../../models/operations/authtokenrevokeapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
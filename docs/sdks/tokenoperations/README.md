# TokenOperations

## Overview

API endpoints for various token related operations, including creating, revoking and deleting access_tokens with specified scopes.

### Available Operations

* [auth_token_create_batch_api](#auth_token_create_batch_api) - Create Access Tokens in Batch
* [auth_token_create_batch_status_api](#auth_token_create_batch_status_api) - Get Batch Token Creation Status

## auth_token_create_batch_api

Create access tokens in batch.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_create_batch_api" method="post" path="/api/{serviceId}/auth/token/create/batch" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.token_operations.auth_token_create_batch_api(service_id: '<id>', request_body: [])

unless res.token_create_batch_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `service_id`                                                                                  | *::String*                                                                                    | :heavy_check_mark:                                                                            | A service ID.                                                                                 |
| `request_body`                                                                                | T::Array<[Models::Components::TokenCreateRequest](../../models/shared/tokencreaterequest.md)> | :heavy_check_mark:                                                                            | N/A                                                                                           |
| `dry_run`                                                                                     | *T.nilable(T::Boolean)*                                                                       | :heavy_minus_sign:                                                                            | If `true`, the request is processed but access tokens are not actually created.<br/>          |

### Response

**[T.nilable(Models::Operations::AuthTokenCreateBatchApiResponse)](../../models/operations/authtokencreatebatchapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## auth_token_create_batch_status_api

Get the status of a batch token creation request.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_create_batch_status_api" method="get" path="/api/{serviceId}/auth/token/create/batch/status/{tokenBatchRequestId}" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.token_operations.auth_token_create_batch_status_api(service_id: '<id>', token_batch_request_id: '<id>')

unless res.token_create_batch_status_response.nil?
  # handle response
end

```

### Parameters

| Parameter                  | Type                       | Required                   | Description                |
| -------------------------- | -------------------------- | -------------------------- | -------------------------- |
| `service_id`               | *::String*                 | :heavy_check_mark:         | A service ID.              |
| `token_batch_request_id`   | *::String*                 | :heavy_check_mark:         | A token batch request ID.<br/> |

### Response

**[T.nilable(Models::Operations::AuthTokenCreateBatchStatusApiResponse)](../../models/operations/authtokencreatebatchstatusapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
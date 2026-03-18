# Tokens

## Overview

### Available Operations

* [process_request](#process_request) - Process Token Request
* [fail_request](#fail_request) - Fail Token Request
* [issue_response](#issue_response) - Issue Token Response

## process_request

This API parses request parameters of an authorization request and returns necessary data for the
authorization server implementation to process the authorization request further.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_api" method="post" path="/api/{serviceId}/auth/token" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.tokens.process_request(service_id: '<id>', token_request: Models::Components::TokenRequest.new(
  parameters: 'grant_type=authorization_code&code=Xv_su944auuBgc5mfUnxXayiiQU9Z4-T_Yae_UfExmo&redirect_uri=https%3A%2F%2Fmy-client.example.com%2Fcb1&code_verifier=dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk',
  client_id: '26478243745571',
  client_secret: 'gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ'
))

unless res.token_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                               | Type                                                                    | Required                                                                | Description                                                             |
| ----------------------------------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `service_id`                                                            | *::String*                                                              | :heavy_check_mark:                                                      | A service ID.                                                           |
| `token_request`                                                         | [Models::Components::TokenRequest](../../models/shared/tokenrequest.md) | :heavy_check_mark:                                                      | N/A                                                                     |

### Response

**[T.nilable(Models::Operations::AuthTokenApiResponse)](../../models/operations/authtokenapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## fail_request

This API generates a content of an error token response that the authorization server implementation
returns to the client application.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_fail_api" method="post" path="/api/{serviceId}/auth/token/fail" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.tokens.fail_request(service_id: '<id>', token_fail_request: Models::Components::TokenFailRequest.new(
  ticket: '83BNqKIhGMyrkvop_7jQjv2Z1612LNdGSQKkvkrf47c',
  reason: Models::Components::TokenFailRequestReason::INVALID_RESOURCE_OWNER_CREDENTIALS
))

unless res.token_fail_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                       | Type                                                                            | Required                                                                        | Description                                                                     |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `service_id`                                                                    | *::String*                                                                      | :heavy_check_mark:                                                              | A service ID.                                                                   |
| `token_fail_request`                                                            | [Models::Components::TokenFailRequest](../../models/shared/tokenfailrequest.md) | :heavy_check_mark:                                                              | N/A                                                                             |

### Response

**[T.nilable(Models::Operations::AuthTokenFailApiResponse)](../../models/operations/authtokenfailapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## issue_response

This API generates a content of a successful token response that the authorization server implementation
returns to the client application.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_token_issue_api" method="post" path="/api/{serviceId}/auth/token/issue" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.tokens.issue_response(service_id: '<id>', token_issue_request: Models::Components::TokenIssueRequest.new(
  ticket: 'p7SXQ9JFjng7KFOZdCMBKcoR3ift7B54l1LGIgQXqEM',
  subject: 'john'
))

unless res.token_issue_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                         | Type                                                                              | Required                                                                          | Description                                                                       |
| --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `service_id`                                                                      | *::String*                                                                        | :heavy_check_mark:                                                                | A service ID.                                                                     |
| `token_issue_request`                                                             | [Models::Components::TokenIssueRequest](../../models/shared/tokenissuerequest.md) | :heavy_check_mark:                                                                | N/A                                                                               |

### Response

**[T.nilable(Models::Operations::AuthTokenIssueApiResponse)](../../models/operations/authtokenissueapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
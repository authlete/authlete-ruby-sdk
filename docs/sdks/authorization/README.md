# Authorization

## Overview

### Available Operations

* [process_request](#process_request) - Process Authorization Request
* [fail_request](#fail_request) - Fail Authorization Request
* [issue_response](#issue_response) - Issue Authorization Response

## process_request

This API parses request parameters of an authorization request and returns necessary data for the authorization server
implementation to process the authorization request further.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_authorization_api" method="post" path="/api/{serviceId}/auth/authorization" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.authorization.process_request(service_id: '<id>', authorization_request: Models::Components::AuthorizationRequest.new(
  parameters: 'response_type=code&client_id=26478243745571&redirect_uri=https%3A%2F%2Fmy-client.example.com%2Fcb1&scope=timeline.read+history.read&code_challenge=E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM&code_challenge_method=S256'
))

unless res.authorization_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                               | Type                                                                                    | Required                                                                                | Description                                                                             |
| --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| `service_id`                                                                            | *::String*                                                                              | :heavy_check_mark:                                                                      | A service ID.                                                                           |
| `authorization_request`                                                                 | [Models::Components::AuthorizationRequest](../../models/shared/authorizationrequest.md) | :heavy_check_mark:                                                                      | N/A                                                                                     |

### Response

**[T.nilable(Models::Operations::AuthAuthorizationApiResponse)](../../models/operations/authauthorizationapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## fail_request

This API generates a content of an error authorization response that the authorization server implementation
returns to the client application.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_authorization_fail_api" method="post" path="/api/{serviceId}/auth/authorization/fail" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.authorization.fail_request(service_id: '<id>', authorization_fail_request: Models::Components::AuthorizationFailRequest.new(
  ticket: 'qA7wGybwArICpbUSutrf5Xc9-i1fHE0ySOHxR1eBoBQ',
  reason: Models::Components::AuthorizationFailRequestReason::NOT_AUTHENTICATED
))

unless res.authorization_fail_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                       | Type                                                                                            | Required                                                                                        | Description                                                                                     |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `service_id`                                                                                    | *::String*                                                                                      | :heavy_check_mark:                                                                              | A service ID.                                                                                   |
| `authorization_fail_request`                                                                    | [Models::Components::AuthorizationFailRequest](../../models/shared/authorizationfailrequest.md) | :heavy_check_mark:                                                                              | N/A                                                                                             |

### Response

**[T.nilable(Models::Operations::AuthAuthorizationFailApiResponse)](../../models/operations/authauthorizationfailapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## issue_response

This API parses request parameters of an authorization request and returns necessary data for the
authorization server implementation to process the authorization request further.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_authorization_issue_api" method="post" path="/api/{serviceId}/auth/authorization/issue" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.authorization.issue_response(service_id: '<id>', authorization_issue_request: Models::Components::AuthorizationIssueRequest.new(
  ticket: 'FFgB9gwb_WXh6g1u-UQ8ZI-d_k4B-o-cm7RkVzI8Vnc',
  subject: 'john'
))

unless res.authorization_issue_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                      | *::String*                                                                                        | :heavy_check_mark:                                                                                | A service ID.                                                                                     |
| `authorization_issue_request`                                                                     | [Models::Components::AuthorizationIssueRequest](../../models/shared/authorizationissuerequest.md) | :heavy_check_mark:                                                                                | N/A                                                                                               |

### Response

**[T.nilable(Models::Operations::AuthAuthorizationIssueApiResponse)](../../models/operations/authauthorizationissueapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
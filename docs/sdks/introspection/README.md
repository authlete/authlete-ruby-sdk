# Introspection

## Overview

### Available Operations

* [process_request](#process_request) - Process Introspection Request
* [standard_process](#standard_process) - Process OAuth 2.0 Introspection Request

## process_request

This API gathers information about an access token.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_introspection_api" method="post" path="/api/{serviceId}/auth/introspection" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.introspection.process_request(service_id: '<id>', introspection_request: Models::Components::IntrospectionRequest.new(
  token: 'VFGsNK-5sXiqterdaR7b5QbRX9VTwVCQB87jbr2_xAI',
  scopes: [
    'history.read',
    'timeline.read',
  ],
  subject: 'john'
))

unless res.introspection_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                               | Type                                                                                    | Required                                                                                | Description                                                                             |
| --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| `service_id`                                                                            | *::String*                                                                              | :heavy_check_mark:                                                                      | A service ID.                                                                           |
| `introspection_request`                                                                 | [Models::Components::IntrospectionRequest](../../models/shared/introspectionrequest.md) | :heavy_check_mark:                                                                      | N/A                                                                                     |

### Response

**[T.nilable(Models::Operations::AuthIntrospectionApiResponse)](../../models/operations/authintrospectionapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## standard_process

This API exists to help your authorization server provide its own introspection API which complies
with [RFC 7662](https://tools.ietf.org/html/rfc7662) (OAuth 2.0 Token Introspection).


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_introspection_standard_api" method="post" path="/api/{serviceId}/auth/introspection/standard" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.introspection.standard_process(service_id: '<id>', standard_introspection_request: Models::Components::StandardIntrospectionRequest.new(
  parameters: 'token=VFGsNK-5sXiqterdaR7b5QbRX9VTwVCQB87jbr2_xAI&token_type_hint=access_token'
))

unless res.standard_introspection_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                               | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                            | *::String*                                                                                              | :heavy_check_mark:                                                                                      | A service ID.                                                                                           |
| `standard_introspection_request`                                                                        | [Models::Components::StandardIntrospectionRequest](../../models/shared/standardintrospectionrequest.md) | :heavy_check_mark:                                                                                      | N/A                                                                                                     |

### Response

**[T.nilable(Models::Operations::AuthIntrospectionStandardApiResponse)](../../models/operations/authintrospectionstandardapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
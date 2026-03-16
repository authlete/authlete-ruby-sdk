# Ciba

## Overview

### Available Operations

* [process_authentication](#process_authentication) - Process Backchannel Authentication Request
* [issue_response](#issue_response) - Issue Backchannel Authentication Response
* [fail_request](#fail_request) - Fail Backchannel Authentication Request
* [complete_request](#complete_request) - Complete Backchannel Authentication

## process_authentication

This API parses request parameters of a [backchannel authentication request](https://openid.net/specs/openid-client-initiated-backchannel-authentication-core-1_0.html#auth_request)
and returns necessary data for the authorization server implementation to process the backchannel
authentication request further.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="backchannel_authentication_api" method="post" path="/api/{serviceId}/backchannel/authentication" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.ciba.process_authentication(service_id: '<id>', backchannel_authentication_request: Models::Components::BackchannelAuthenticationRequest.new(
  parameters: 'login_hint=john&scope=openid&client_notification_token=my-client-notification-token&user_code=my-user-code',
  client_id: '26862190133482',
  client_secret: '8J9pAEX6IQw7lYtYGsc_s9N4jlEz_DfkoCHIswJjFjfgKZX-nC4EvKtaHXcP9mHBfS7IU4jytjSZZpaK9UJ77A'
))

unless res.backchannel_authentication_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                       | Type                                                                                                            | Required                                                                                                        | Description                                                                                                     |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                    | *::String*                                                                                                      | :heavy_check_mark:                                                                                              | A service ID.                                                                                                   |
| `backchannel_authentication_request`                                                                            | [Models::Components::BackchannelAuthenticationRequest](../../models/shared/backchannelauthenticationrequest.md) | :heavy_check_mark:                                                                                              | N/A                                                                                                             |

### Response

**[T.nilable(Models::Operations::BackchannelAuthenticationApiResponse)](../../models/operations/backchannelauthenticationapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## issue_response

This API prepares JSON that contains an `auth_req_id`. The JSON should be used as the response body
of the response which is returned to the client from the [backchannel authentication endpoint](https://openid.net/specs/openid-client-initiated-backchannel-authentication-core-1_0.html#auth_backchannel_endpoint)


### Example Usage

<!-- UsageSnippet language="ruby" operationID="backchannel_authentication_issue_api" method="post" path="/api/{serviceId}/backchannel/authentication/issue" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.ciba.issue_response(service_id: '<id>', backchannel_authentication_issue_request: Models::Components::BackchannelAuthenticationIssueRequest.new(
  ticket: 'NFIHGx_btVrWmtAD093D-87JxvT4DAtuijEkLVHbS4Q'
))

unless res.backchannel_authentication_issue_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                 | Type                                                                                                                      | Required                                                                                                                  | Description                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                              | *::String*                                                                                                                | :heavy_check_mark:                                                                                                        | A service ID.                                                                                                             |
| `backchannel_authentication_issue_request`                                                                                | [Models::Components::BackchannelAuthenticationIssueRequest](../../models/shared/backchannelauthenticationissuerequest.md) | :heavy_check_mark:                                                                                                        | N/A                                                                                                                       |

### Response

**[T.nilable(Models::Operations::BackchannelAuthenticationIssueApiResponse)](../../models/operations/backchannelauthenticationissueapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## fail_request

The API prepares JSON that contains an error. The JSON should be used as the response body of the
response which is returned to the client from the [backchannel authentication endpoint](https://openid.net/specs/openid-client-initiated-backchannel-authentication-core-1_0.html#auth_backchannel_endpoint).


### Example Usage

<!-- UsageSnippet language="ruby" operationID="backchannel_authentication_fail_api" method="post" path="/api/{serviceId}/backchannel/authentication/fail" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.ciba.fail_request(service_id: '<id>', backchannel_authentication_fail_request: Models::Components::BackchannelAuthenticationFailRequest.new(
  ticket: '<value>',
  reason: Models::Components::BackchannelAuthenticationFailRequestReason::MISSING_USER_CODE
))

unless res.backchannel_authentication_fail_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                               | Type                                                                                                                    | Required                                                                                                                | Description                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                            | *::String*                                                                                                              | :heavy_check_mark:                                                                                                      | A service ID.                                                                                                           |
| `backchannel_authentication_fail_request`                                                                               | [Models::Components::BackchannelAuthenticationFailRequest](../../models/shared/backchannelauthenticationfailrequest.md) | :heavy_check_mark:                                                                                                      | N/A                                                                                                                     |

### Response

**[T.nilable(Models::Operations::BackchannelAuthenticationFailApiResponse)](../../models/operations/backchannelauthenticationfailapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## complete_request

This API returns information about what action the authorization server should take after it receives
the result of end-user's decision about whether the end-user has approved or rejected a client application's
request on the authentication device.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="backchannel_authentication_complete_api" method="post" path="/api/{serviceId}/backchannel/authentication/complete" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.ciba.complete_request(service_id: '<id>', backchannel_authentication_complete_request: Models::Components::BackchannelAuthenticationCompleteRequest.new(
  ticket: 'NFIHGx_btVrWmtAD093D-87JxvT4DAtuijEkLVHbS4Q',
  result: Models::Components::BackchannelAuthenticationCompleteRequestResult::AUTHORIZED,
  subject: 'john'
))

unless res.backchannel_authentication_complete_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                       | Type                                                                                                                            | Required                                                                                                                        | Description                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                    | *::String*                                                                                                                      | :heavy_check_mark:                                                                                                              | A service ID.                                                                                                                   |
| `backchannel_authentication_complete_request`                                                                                   | [Models::Components::BackchannelAuthenticationCompleteRequest](../../models/shared/backchannelauthenticationcompleterequest.md) | :heavy_check_mark:                                                                                                              | N/A                                                                                                                             |

### Response

**[T.nilable(Models::Operations::BackchannelAuthenticationCompleteApiResponse)](../../models/operations/backchannelauthenticationcompleteapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
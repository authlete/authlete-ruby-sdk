# PushedAuthorization

## Overview

### Available Operations

* [create](#create) - Process Pushed Authorization Request

## create

This API creates a pushed request authorization. It authenticates the client and creates a authorization_uri to be returned by the authorization server.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="pushed_auth_req_api" method="post" path="/api/{serviceId}/pushed_auth_req" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.pushed_authorization.create(pushed_authorization_request: Models::Components::PushedAuthorizationRequest.new(
  parameters: 'response_type=code%20id_token&client_id=5921531358155430&redirect_uri=https%3A%2F%2Fserver.example.com%2Fcb&state=SOME_VALUE_ABLE_TO_PREVENT_CSRF&scope=openid&nonce=SOME_VALUE_ABLE_TO_PREVENT_REPLAY_ATTACK&code_challenge=5ZWDQJiryK3eaLtSeFV8y1XySMCWtyITxICLaTwvK8g&code_challenge_method=S256',
  client_id: '5921531358155430',
  client_secret: 'P_FouxWlI7zcOep_9vBwR9qMAVJQiCiUiK1HrAP4GziOyezHQpqY0f5dHXK4JT4tnvI51OkbWVoEM9GnOyJViA'
))

unless res.pushed_authorization_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `pushed_authorization_request`                                                                      | [Models::Components::PushedAuthorizationRequest](../../models/shared/pushedauthorizationrequest.md) | :heavy_check_mark:                                                                                  | N/A                                                                                                 |
| `service_id`                                                                                        | *T.nilable(::String)*                                                                               | :heavy_minus_sign:                                                                                  | A service ID.                                                                                       |

### Response

**[T.nilable(Models::Operations::PushedAuthReqApiResponse)](../../models/operations/pushedauthreqapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
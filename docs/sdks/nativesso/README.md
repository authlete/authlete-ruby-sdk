# NativeSso

## Overview

### Available Operations

* [process_request](#process_request) - Native SSO Processing
* [logout](#logout) - Native SSO Logout Processing

## process_request

This API should be called by the implementation of a token endpoint to generate the ID token and
token response that comply with [OpenID Connect Native SSO for Mobile Apps 1.0](https://openid.net/specs/openid-connect-native-sso-1_0.html)
(Native SSO) when Authlete’s `/auth/token` response indicates `action = NATIVE_SSO` (after you validate
the session id and verify or generate the device secret as required by the flow). The token endpoint
implementation should retrieve the value of `action` from the response and take the following steps
according to the value.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="native_sso_api" method="post" path="/api/{serviceId}/nativesso" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.native_sso.process_request(service_id: '715948317', native_sso_request: Models::Components::NativeSsoRequest.new(
  access_token: '_kh1aygxZ5NKLYKCJRM8M_AYvDg2wCWoprQDjfO87ZWq',
  refresh_token: 'kHUGSt_d3LSgiCQzH7wa5TpwIHWgjAZGw14zZV7hRqw',
  claims: '{"given_name":"John","family_name":"Brown","email":"test@example.com"}',
  device_secret: 'my-ds'
))

unless res.native_sso_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                       | Type                                                                            | Required                                                                        | Description                                                                     | Example                                                                         |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `service_id`                                                                    | *::String*                                                                      | :heavy_check_mark:                                                              | A service ID.                                                                   | 715948317                                                                       |
| `native_sso_request`                                                            | [Models::Components::NativeSsoRequest](../../models/shared/nativessorequest.md) | :heavy_check_mark:                                                              | N/A                                                                             |                                                                                 |

### Response

**[T.nilable(Models::Operations::NativeSsoApiResponse)](../../models/operations/nativessoapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## logout

The `/nativesso/logout` API is supposed to be used to support the concept of "logout from all applications"
in the context of [OpenID Connect Native SSO for Mobile Apps 1.0](https://openid.net/specs/openid-connect-native-sso-1_0.html)
(Native SSO). This is accomplished by deleting access/refresh token records associated with the
specified session ID. In Authlete's implementation, access/refresh token records can be associated
with a session ID only through the mechanism introduced by Native SSO.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="native_sso_logout_api" method="post" path="/api/{serviceId}/nativesso/logout" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.native_sso.logout(service_id: '<id>', native_sso_logout_request: Models::Components::NativeSsoLogoutRequest.new(
  session_id: 'my-sid'
))

unless res.native_sso_logout_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                   | Type                                                                                        | Required                                                                                    | Description                                                                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `service_id`                                                                                | *::String*                                                                                  | :heavy_check_mark:                                                                          | A service ID.                                                                               |
| `native_sso_logout_request`                                                                 | [Models::Components::NativeSsoLogoutRequest](../../models/shared/nativessologoutrequest.md) | :heavy_check_mark:                                                                          | N/A                                                                                         |

### Response

**[T.nilable(Models::Operations::NativeSsoLogoutApiResponse)](../../models/operations/nativessologoutapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
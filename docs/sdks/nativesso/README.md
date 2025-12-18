# NativeSso
(*native_sso*)

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

**OK**

When the action is `OK`, it indicates that the `/nativesso` API processing has successfully completed.
In this case, the token endpoint implementation should return a successful response (`200 OK`) to
the client. The value of the responseContent property in the `/nativesso` API response can be used
directly as the message body of the token response. Therefore, the success response can be constructed
as follows:

```
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: no-store

(Embed the value of responseContent here.)
```

**INTERNAL_SERVER_ERROR**

When the action is `INTERNAL_SERVER_ERROR`, it indicates that something has gone wrong on the Authlete
side. For example, an issue such as a database error might have occurred when retrieving the access
token specified by the accessToken parameter from the database.

In such cases, the token endpoint implementation should return an error response to the client.
The simplest implementation would be to return a `500 Internal Server Error`.

```
HTTP/1.1 500 Internal Server Error
Content-Type: application/json
Cache-Control: no-store

(Embed the value of responseContent here.)
```

However, in a production environment, it may be better to return a more abstract error (one that
does not directly describe the nature of the issue), rather than a `500` error.

**CALLER_ERROR**

When the action is `CALLER_ERROR`, it indicates that the issue lies with the caller of the API
(i.e., the implementation of the OpenID Provider). For example, this could be due to missing a
required parameter such as accessToken.

If `CALLER_ERROR` is returned, please review the implementation of your OpenID Provider.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="native_sso_api" method="post" path="/api/{serviceId}/nativesso" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.native_sso.process_request(service_id: '715948317', native_sso_request: Models::Components::NativeSsoRequest.new(
  access_token: '_kh1aygxZ5NKLYKCJRM8M_AYvDg2wCWoprQDjfO87ZWq',
  refresh_token: 'kHUGSt_d3LSgiCQzH7wa5TpwIHWgjAZGw14zZV7hRqw',
  claims: '{"given_name":"John","family_name":"Brown","email":"test@example.com"}',
  device_secret: 'my-ds',
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

A response from the `/nativesso/logout` API contains `action` response parameter. The possible values
are:

**OK**

When the action is `OK`, it indicates that the `/nativesso/logout` API call completed successfully.

**SERVER_ERROR**

When the action is `SERVER_ERROR`, it indicates that something has gone wrong on the Authlete side.

**CALLER_ERROR**

When the action is `CALLER_ERROR`, it indicates that the `/nativesso/logout` API call contained a
problem. For example, the call may have been missing the required request parameter `sessionId`.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="native_sso_logout_api" method="post" path="/api/{serviceId}/nativesso/logout" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.native_sso.logout(service_id: '<id>', native_sso_logout_request: Models::Components::NativeSsoLogoutRequest.new(
  session_id: 'my-sid',
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
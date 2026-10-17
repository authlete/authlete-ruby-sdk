# BackChannelLogout

## Overview

### Available Operations

* [backchannel_logout_token_api](#backchannel_logout_token_api) - Backchannel Logout Token Issuing

## backchannel_logout_token_api

The `/backchannel/logout/token` API issues a logout token for a client application
in the context of [OpenID Connect Back-Channel Logout 1.0](https://openid.net/specs/openid-connect-backchannel-1_0.html).


### Example Usage

<!-- UsageSnippet language="ruby" operationID="backchannel_logout_token_api" method="post" path="/api/{serviceId}/backchannel/logout/token" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.back_channel_logout.backchannel_logout_token_api(service_id: '<id>', backchannel_logout_token_request: Models::Components::BackchannelLogoutTokenRequest.new(
  client_identifier: '1140735077',
  subject: 'user123',
  session_id: 'my-sid'
))

unless res.backchannel_logout_token_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                 | Type                                                                                                      | Required                                                                                                  | Description                                                                                               |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                              | *::String*                                                                                                | :heavy_check_mark:                                                                                        | A service ID.                                                                                             |
| `backchannel_logout_token_request`                                                                        | [Models::Components::BackchannelLogoutTokenRequest](../../models/shared/backchannellogouttokenrequest.md) | :heavy_check_mark:                                                                                        | N/A                                                                                                       |

### Response

**[T.nilable(Models::Operations::BackchannelLogoutTokenApiResponse)](../../models/operations/backchannellogouttokenapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
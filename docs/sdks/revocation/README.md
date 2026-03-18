# Revocation

## Overview

### Available Operations

* [process_request](#process_request) - Process Revocation Request

## process_request

This API revokes access tokens and refresh tokens.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_revocation_api" method="post" path="/api/{serviceId}/auth/revocation" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.revocation.process_request(service_id: '<id>', revocation_request: Models::Components::RevocationRequest.new(
  parameters: 'VFGsNK-5sXiqterdaR7b5QbRX9VTwVCQB87jbr2_xAI&token_type_hint=access_token',
  client_id: '26478243745571',
  client_secret: 'gXz97ISgLs4HuXwOZWch8GEmgL4YMvUJwu3er_kDVVGcA0UOhA9avLPbEmoeZdagi9yC_-tEiT2BdRyH9dbrQQ'
))

unless res.revocation_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                         | Type                                                                              | Required                                                                          | Description                                                                       |
| --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `service_id`                                                                      | *::String*                                                                        | :heavy_check_mark:                                                                | A service ID.                                                                     |
| `revocation_request`                                                              | [Models::Components::RevocationRequest](../../models/shared/revocationrequest.md) | :heavy_check_mark:                                                                | N/A                                                                               |

### Response

**[T.nilable(Models::Operations::AuthRevocationApiResponse)](../../models/operations/authrevocationapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
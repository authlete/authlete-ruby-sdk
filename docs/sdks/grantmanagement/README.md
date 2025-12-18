# GrantManagement
(*grant_management*)

## Overview

### Available Operations

* [process_request](#process_request) - Process Grant Management Request

## process_request

The API is for the implementation of the grant management endpoint which is
defined in "[Grant Management for OAuth 2.0](https://openid.net/specs/fapi-grant-management.html)".


### Example Usage

<!-- UsageSnippet language="ruby" operationID="grant_m_api" method="post" path="/api/{serviceId}/gm" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.grant_management.process_request(service_id: '<id>', g_m_request: Models::Components::GMRequest.new(
  access_token: 'eyJhbGciOiJFUzI1NiJ9.eyJleHAiOjE1NTk4MTE3NTAsImlzcyI6IjU3Mjk3NDA4ODY3In0K.csmdholMVcmjqHe59YWgLGNvm7I5Whp4phQCoGxyrlRGMnTgsfxtwyxBgMXQqEPD5q5k9FaEWNk37K8uAtSwrA',
  gm_action: Models::Components::GrantManagementAction::REVOKE,
  grant_id: '57297408867',
))

unless res.g_m_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                         | Type                                                              | Required                                                          | Description                                                       |
| ----------------------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------- |
| `service_id`                                                      | *::String*                                                        | :heavy_check_mark:                                                | A service ID.                                                     |
| `g_m_request`                                                     | [Models::Components::GMRequest](../../models/shared/gmrequest.md) | :heavy_check_mark:                                                | N/A                                                               |

### Response

**[T.nilable(Models::Operations::GrantMApiResponse)](../../models/operations/grantmapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
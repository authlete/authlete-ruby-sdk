# JoseObject
(*jose_object*)

## Overview

API endpoints for JOSE objects.

### Available Operations

* [jose_verify_api](#jose_verify_api) - Verify JOSE

## jose_verify_api

This API verifies a JOSE object.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="jose_verify_api" method="post" path="/api/{serviceId}/jose/verify" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.jose_object.jose_verify_api(service_id: '<id>', jose_verify_request: Models::Components::JoseVerifyRequest.new(
  jose: 'eyJhbGciOiJFUzI1NiJ9.eyJleHAiOjE1NTk4MTE3NTAsImlzcyI6IjU3Mjk3NDA4ODY3In0K.csmdholMVcmjqHe59YWgLGNvm7I5Whp4phQCoGxyrlRGMnTgsfxtwyxBgMXQqEPD5q5k9FaEWNk37K8uAtSwrA',
  clock_skew: 100,
  client_identifier: '57297408867',
  signed_by_client: true,
))

unless res.jose_verify_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                    | Type                                                                                         | Required                                                                                     | Description                                                                                  |
| -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| `service_id`                                                                                 | *::String*                                                                                   | :heavy_check_mark:                                                                           | A service ID.                                                                                |
| `jose_verify_request`                                                                        | [T.nilable(Models::Components::JoseVerifyRequest)](../../models/shared/joseverifyrequest.md) | :heavy_minus_sign:                                                                           | N/A                                                                                          |

### Response

**[T.nilable(Models::Operations::JoseVerifyApiResponse)](../../models/operations/joseverifyapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
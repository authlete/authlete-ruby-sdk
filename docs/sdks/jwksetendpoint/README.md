# JWKSetEndpoint
(*jwk_set_endpoint*)

## Overview

API endpoints for to generate JSON Web Key Set (JWKS) for a service.

### Available Operations

* [service_jwks_get_api](#service_jwks_get_api) - Get JWK Set

## service_jwks_get_api

This API gathers JWK Set information for a service so that its client applications can verify
signatures by the service and encrypt their requests to the service.
### Description
This API is supposed to be called from within the implementation of the jwk set endpoint of the
service where the service that supports OpenID Connect must expose its JWK Set information so that
client applications can verify signatures by the service and encrypt their requests to the service.
The URI of the endpoint can be found as the value of `jwks\_uri` in [OpenID Provider Metadata](https://openid.net/specs/openid-connect-discovery-1\_0.html#ProviderMetadata)
if the service supports [OpenID Connect Discovery 1.0](https://openid.net/specs/openid-connect-discovery-1\_0.html).


### Example Usage

<!-- UsageSnippet language="ruby" operationID="service_jwks_get_api" method="get" path="/api/{serviceId}/service/jwks/get" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.jwk_set_endpoint.service_jwks_get_api(service_id: '<id>')

unless res.service_jwks_get_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                         | Type                                                                                                                                                                                                              | Required                                                                                                                                                                                                          | Description                                                                                                                                                                                                       |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                                                                                                      | *::String*                                                                                                                                                                                                        | :heavy_check_mark:                                                                                                                                                                                                | A service ID.                                                                                                                                                                                                     |
| `include_private_keys`                                                                                                                                                                                            | *T.nilable(T::Boolean)*                                                                                                                                                                                           | :heavy_minus_sign:                                                                                                                                                                                                | The boolean value that indicates whether the response should include the private keys associated with the service or not. If `true`, the private keys are included in the response. The default value is `false`. |
| `pretty`                                                                                                                                                                                                          | *T.nilable(T::Boolean)*                                                                                                                                                                                           | :heavy_minus_sign:                                                                                                                                                                                                | This boolean value indicates whether the JSON in the response should be formatted or not. If `true`, the JSON in the response is pretty-formatted. The default value is `false`.                                  |

### Response

**[T.nilable(Models::Operations::ServiceJwksGetApiResponse)](../../models/operations/servicejwksgetapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
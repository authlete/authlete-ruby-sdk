# Federation

## Overview

### Available Operations

* [configuration](#configuration) - Process Entity Configuration Request
* [registration](#registration) - Process Federation Registration Request

## configuration

This API gathers the federation configuration about a service.
The authorization server implementation should
retrieve the value of the `action`
response parameter from the API response and take the following steps
according to the value.
### `OK`
When the value of the  `action` response
parameter is `OK`, it means that Authlete
could prepare an entity configuration successfully.
In this case, the implementation of the entity configuration endpoint of the
authorization server should return an HTTP response to the client application
with the HTTP status code "`200 OK`" and the content type
"`application/entity-statement+jwt`". The message body (= an entity
configuration in the JWT format) of the response has been prepared by
Authlete's `/federation/configuration` API and it is available as the
`responseContent` response parameter.
The implementation of the entity configuration endpoint can construct an
HTTP response by doing like below.
```
200 OK
Content-Type: application/entity-statement+jwt
(Other HTTP headers)
(the value of the responseContent response parameter)
```
### `NOT_FOUND`
When the value of the  `action` response
parameter is `NOT_FOUND`, it means that
the service configuration has not enabled the feature of [OpenID Connect
Federation 1.0](https://openid.net/specs/openid-connect-federation-1_0.html) and so the client application should have not access the
entity configuration endpoint.
In this case, the implementation of the entity configuration endpoint of the
authorization server should return an HTTP response to the client application
with the HTTP status code "`404 Not Found`" and the content type
"`application/json`". The message body (= error information in the JSON
format) of the response has been prepared by Authlete's
`/federation/configuration` API and it is available as the
`responseContent` response parameter.
The implementation of the entity configuration endpoint can construct an
HTTP response by doing like below.
```
404 Not Found
Content-Type: application/json
(Other HTTP headers)
(the value of the responseContent response parameter)
```
### `INTERNAL_SERVER_ERROR`
could prepare an entity configuration successfully.
In this case, the implementation of the entity configuration endpoint of the
authorization server should return an HTTP response to the client application
with the HTTP status code "`200 OK`" and the content type
"`application/entity-statement+jwt`". The message body (= an entity
configuration in the JWT format) of the response has been prepared by
Authlete's `/federation/configuration` API and it is available as the
`responseContent` response parameter.
The implementation of the entity configuration endpoint can construct an
HTTP response by doing like below.
```
200 OK
Content-Type: application/entity-statement+jwt
(Other HTTP headers)
(the value of the responseContent response parameter)
```


### Example Usage

<!-- UsageSnippet language="ruby" operationID="federation_configuration_api" method="post" path="/api/{serviceId}/federation/configuration" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.federation.configuration(service_id: '<id>')

unless res.federation_configuration_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                | Type                                                                                                                                     | Required                                                                                                                                 | Description                                                                                                                              |
| ---------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                             | *::String*                                                                                                                               | :heavy_check_mark:                                                                                                                       | A service ID.                                                                                                                            |
| `request_body`                                                                                                                           | [T.nilable(Models::Operations::FederationConfigurationApiRequestBody)](../../models/operations/federationconfigurationapirequestbody.md) | :heavy_minus_sign:                                                                                                                       | N/A                                                                                                                                      |

### Response

**[T.nilable(Models::Operations::FederationConfigurationApiResponse)](../../models/operations/federationconfigurationapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## registration

The Authlete API is for implementations of the **federation registration
endpoint** that accepts "explicit client registration". Its details are
defined in [OpenID Connect Federation 1.0](https://openid.net/specs/openid-connect-federation-1_0.html).
The endpoint accepts `POST` requests whose `Content-Type`
is either of the following.
1. `application/entity-statement+jwt`- `application/trust-chain+json`
When the `Content-Type` of a request is
`application/entity-statement+jwt`, the content of the request is
the entity configuration of a relying party that is to be registered.
In this case, the implementation of the federation registration endpoint
should call Authlete's `/federation/registration` API with the
entity configuration set to the `entityConfiguration` request
parameter.
On the other hand, when the `Content-Type` of a request is
`application/trust-chain+json`, the content of the request is a
JSON array that contains entity statements in JWT format. The sequence
of the entity statements composes the trust chain of a relying party
that is to be registered. In this case, the implementation of the
federation registration endpoint should call Authlete's
`/federation/registration` API with the trust chain set to the
`trustChain` request parameter.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="federation_registration_api" method="post" path="/api/{serviceId}/federation/registration" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.federation.registration(service_id: '<id>', federation_registration_request: Models::Components::FederationRegistrationRequest.new())

unless res.federation_registration_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                 | Type                                                                                                      | Required                                                                                                  | Description                                                                                               |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                              | *::String*                                                                                                | :heavy_check_mark:                                                                                        | A service ID.                                                                                             |
| `federation_registration_request`                                                                         | [Models::Components::FederationRegistrationRequest](../../models/shared/federationregistrationrequest.md) | :heavy_check_mark:                                                                                        | N/A                                                                                                       |

### Response

**[T.nilable(Models::Operations::FederationRegistrationApiResponse)](../../models/operations/federationregistrationapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
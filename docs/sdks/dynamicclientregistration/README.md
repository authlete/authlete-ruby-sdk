# DynamicClientRegistration

## Overview

### Available Operations

* [register](#register) - Register Client
* [retrieve](#retrieve) - Get Client
* [update](#update) - Update Client
* [destroy](#destroy) - Delete Client

## register

Register a client. This API is supposed to be used to implement a client registration endpoint that
complies with [RFC 7591](https://datatracker.ietf.org/doc/html/rfc7591) (OAuth 2.0 Dynamic Client
Registration Protocol).


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_registration_api" method="post" path="/api/{serviceId}/client/registration" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.dynamic_client_registration.register(service_id: '<id>', request_body: Models::Operations::ClientRegistrationApiRequestBody.new(
  json: '{ "client_name": "My Dynamic Client" }'
))

unless res.client_registration_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                           | Type                                                                                                                | Required                                                                                                            | Description                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                        | *::String*                                                                                                          | :heavy_check_mark:                                                                                                  | A service ID.                                                                                                       |
| `request_body`                                                                                                      | [Models::Operations::ClientRegistrationApiRequestBody](../../models/operations/clientregistrationapirequestbody.md) | :heavy_check_mark:                                                                                                  | N/A                                                                                                                 |

### Response

**[T.nilable(Models::Operations::ClientRegistrationApiResponse)](../../models/operations/clientregistrationapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## retrieve

Get a dynamically registered client. This API is supposed to be used to implement a client registration
management endpoint that complies with [RFC 7592](https://datatracker.ietf.org/doc/html/rfc7592)
(OAuth 2.0 Dynamic Registration Management).


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_registration_get_api" method="post" path="/api/{serviceId}/client/registration/get" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.dynamic_client_registration.retrieve(service_id: '<id>', request_body: Models::Operations::ClientRegistrationGetApiRequestBody.new(
  token: 'qs4Tu5TV7qqDYT93bFs6ISyhTByMF9o-54GY4JU5vTA',
  client_id: '26837717140341'
))

unless res.client_registration_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                 | Type                                                                                                                      | Required                                                                                                                  | Description                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                              | *::String*                                                                                                                | :heavy_check_mark:                                                                                                        | A service ID.                                                                                                             |
| `request_body`                                                                                                            | [Models::Operations::ClientRegistrationGetApiRequestBody](../../models/operations/clientregistrationgetapirequestbody.md) | :heavy_check_mark:                                                                                                        | N/A                                                                                                                       |

### Response

**[T.nilable(Models::Operations::ClientRegistrationGetApiResponse)](../../models/operations/clientregistrationgetapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update

Update a dynamically registered client. This API is supposed to be used to implement a client
registration management endpoint that complies with [RFC 7592](https://datatracker.ietf.org/doc/html/rfc7592)
(OAuth 2.0 Dynamic Registration Management).


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_registration_update_api" method="post" path="/api/{serviceId}/client/registration/update" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.dynamic_client_registration.update(service_id: '<id>', request_body: Models::Operations::ClientRegistrationUpdateApiRequestBody.new(
  json: '{"client_name":"My Updated Dynamic Client","default_max_age":0,"registration_client_uri":"https://my-service.example.com/dcr/register/26837717140341","client_id":"26837717140341","token_endpoint_auth_method":"client_secret_basic","require_pushed_authorization_requests":false,"backchannel_user_code_parameter":false,"client_secret":"bMsjvZm2FE1_mqJgxhmYj_Wr8rA0Pia_A_j-V076qQm6-P1edKB055W579GBe7MSbOdxZ3dJKsKinCtdIFwxpw","tls_client_certificate_bound_access_tokens":false,"id_token_signed_response_alg":"RS256","subject_type":"public","require_signed_request_object":false}',
  token: 'qs4Tu5TV7qqDYT93bFs6ISyhTByMF9o-54GY4JU5vTA',
  client_id: '26837717140341'
))

unless res.client_registration_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                       | Type                                                                                                                            | Required                                                                                                                        | Description                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                    | *::String*                                                                                                                      | :heavy_check_mark:                                                                                                              | A service ID.                                                                                                                   |
| `request_body`                                                                                                                  | [Models::Operations::ClientRegistrationUpdateApiRequestBody](../../models/operations/clientregistrationupdateapirequestbody.md) | :heavy_check_mark:                                                                                                              | N/A                                                                                                                             |

### Response

**[T.nilable(Models::Operations::ClientRegistrationUpdateApiResponse)](../../models/operations/clientregistrationupdateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## destroy

Delete a dynamically registered client. This API is supposed to be used to implement a client
registration management endpoint that complies with [RFC 7592](https://datatracker.ietf.org/doc/html/rfc7592)
(OAuth 2.0 Dynamic Registration Management).


### Example Usage

<!-- UsageSnippet language="ruby" operationID="client_registration_delete_api" method="post" path="/api/{serviceId}/client/registration/delete" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.dynamic_client_registration.destroy(service_id: '<id>', request_body: Models::Operations::ClientRegistrationDeleteApiRequestBody.new(
  token: 'qs4Tu5TV7qqDYT93bFs6ISyhTByMF9o-54GY4JU5vTA',
  client_id: '26837717140341'
))

unless res.client_registration_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                       | Type                                                                                                                            | Required                                                                                                                        | Description                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                                    | *::String*                                                                                                                      | :heavy_check_mark:                                                                                                              | A service ID.                                                                                                                   |
| `request_body`                                                                                                                  | [Models::Operations::ClientRegistrationDeleteApiRequestBody](../../models/operations/clientregistrationdeleteapirequestbody.md) | :heavy_check_mark:                                                                                                              | N/A                                                                                                                             |

### Response

**[T.nilable(Models::Operations::ClientRegistrationDeleteApiResponse)](../../models/operations/clientregistrationdeleteapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
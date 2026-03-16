# DeviceFlow

## Overview

### Available Operations

* [authorization](#authorization) - Process Device Authorization Request
* [verification](#verification) - Process Device Verification Request
* [complete_request](#complete_request) - Complete Device Authorization

## authorization

This API parses request parameters of a [device authorization request](https://datatracker.ietf.org/doc/html/rfc8628#section-3.1)
and returns necessary data for the authorization server implementation to process the device authorization
request further.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="device_authorization_api" method="post" path="/api/{serviceId}/device/authorization" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.device_flow.authorization(service_id: '<id>', device_authorization_request: Models::Components::DeviceAuthorizationRequest.new(
  parameters: 'client_id=26888344961664&scope=history.read',
  client_id: '26888344961664',
  client_secret: 'SfnYOLkJdofrb_66mTd6q03_SDoDEUnpXtvqFaE4k6L6UcpZzbdVJi2GpBj48AvGeDDllwsTruC62WYqQ_LGog'
))

unless res.device_authorization_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                        | *::String*                                                                                          | :heavy_check_mark:                                                                                  | A service ID.                                                                                       |
| `device_authorization_request`                                                                      | [Models::Components::DeviceAuthorizationRequest](../../models/shared/deviceauthorizationrequest.md) | :heavy_check_mark:                                                                                  | N/A                                                                                                 |

### Response

**[T.nilable(Models::Operations::DeviceAuthorizationApiResponse)](../../models/operations/deviceauthorizationapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## verification

The API returns information associated with a user code.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="device_verification_api" method="post" path="/api/{serviceId}/device/verification" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.device_flow.verification(service_id: '<id>', device_verification_request: Models::Components::DeviceVerificationRequest.new(
  user_code: 'XWWKPBWVXQ'
))

unless res.device_verification_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                      | *::String*                                                                                        | :heavy_check_mark:                                                                                | A service ID.                                                                                     |
| `device_verification_request`                                                                     | [Models::Components::DeviceVerificationRequest](../../models/shared/deviceverificationrequest.md) | :heavy_check_mark:                                                                                | N/A                                                                                               |

### Response

**[T.nilable(Models::Operations::DeviceVerificationApiResponse)](../../models/operations/deviceverificationapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## complete_request

This API returns information about what action the authorization server should take after it receives
the result of end-user's decision about whether the end-user has approved or rejected a client
application's request.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="device_complete_api" method="post" path="/api/{serviceId}/device/complete" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.device_flow.complete_request(service_id: '<id>', device_complete_request: Models::Components::DeviceCompleteRequest.new(
  user_code: 'XWWKPBWVXQ',
  result: Models::Components::DeviceCompleteRequestResult::AUTHORIZED,
  subject: 'john'
))

unless res.device_complete_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `service_id`                                                                              | *::String*                                                                                | :heavy_check_mark:                                                                        | A service ID.                                                                             |
| `device_complete_request`                                                                 | [Models::Components::DeviceCompleteRequest](../../models/shared/devicecompleterequest.md) | :heavy_check_mark:                                                                        | N/A                                                                                       |

### Response

**[T.nilable(Models::Operations::DeviceCompleteApiResponse)](../../models/operations/devicecompleteapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
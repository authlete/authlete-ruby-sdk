# Service

## Overview

### Available Operations

* [create](#create) - Create Service (IDP)
* [remove](#remove) - Remove Service (IDP) ⚡

## create

Create a new service on the API server, belonging to the specified organization.
A service can be created with an organization token or by a user with the CREATE_SERVICE role.

This endpoint is hosted on the Authlete IdP server (`https://login.authlete.com`),
not on the regional API clusters.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="service_create_idp_api" method="post" path="/api/service" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Components::ServiceCreateIdpRequest.new(
  api_server_id: 76_281,
  organization_id: 123_456_789_012_345,
  service: Models::Components::ServiceInput.new(
    service_name: 'My service',
    issuer: 'https://my-service.example.com'
  )
)
res = s.service.create(request: req)

unless res.service.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `request`                                                                                     | [Models::Components::ServiceCreateIdpRequest](../../models/shared/servicecreateidprequest.md) | :heavy_check_mark:                                                                            | The request object to use for the request.                                                    |
| `server_url`                                                                                  | *String*                                                                                      | :heavy_minus_sign:                                                                            | An optional server URL to use.                                                                |

### Response

**[T.nilable(Models::Operations::ServiceCreateIdpApiResponse)](../../models/operations/servicecreateidpapiresponse.md)**

### Errors

| Error Type               | Status Code              | Content Type             |
| ------------------------ | ------------------------ | ------------------------ |
| Models::Errors::IdpError | 400, 401, 403            | application/json         |
| Models::Errors::IdpError | 500                      | application/json         |
| Errors::APIError         | 4XX, 5XX                 | \*/\*                    |

## remove

Delete a service from the API server.
A service can be deleted with an organization token or by a user with the MODIFY_SERVICE role.

This endpoint is hosted on the Authlete IdP server (`https://login.authlete.com`),
not on the regional API clusters.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="service_remove_idp_api" method="post" path="/api/service/remove" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Components::ServiceRemoveIdpRequest.new(
  api_server_id: 76_281,
  organization_id: 123_456_789_012_345,
  service_id: 21_653_835_348_762
)
res = s.service.remove(request: req)

if res.status_code == 200
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `request`                                                                                     | [Models::Components::ServiceRemoveIdpRequest](../../models/shared/serviceremoveidprequest.md) | :heavy_check_mark:                                                                            | The request object to use for the request.                                                    |
| `server_url`                                                                                  | *String*                                                                                      | :heavy_minus_sign:                                                                            | An optional server URL to use.                                                                |

### Response

**[T.nilable(Models::Operations::ServiceRemoveIdpApiResponse)](../../models/operations/serviceremoveidpapiresponse.md)**

### Errors

| Error Type               | Status Code              | Content Type             |
| ------------------------ | ------------------------ | ------------------------ |
| Models::Errors::IdpError | 400, 401, 403            | application/json         |
| Models::Errors::IdpError | 500                      | application/json         |
| Errors::APIError         | 4XX, 5XX                 | \*/\*                    |
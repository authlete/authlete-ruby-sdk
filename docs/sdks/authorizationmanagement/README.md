# AuthorizationManagement

## Overview

### Available Operations

* [ticket_info](#ticket_info) - Get Ticket Information
* [update_ticket](#update_ticket) - Update Ticket Information

## ticket_info

Get Ticket Information

### Example Usage

<!-- UsageSnippet language="ruby" operationID="authorization_ticket_info_post_api" method="post" path="/api/{serviceId}/auth/authorization/ticket/info" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.authorization_management.ticket_info(authorization_ticket_info_request: Models::Components::AuthorizationTicketInfoRequest.new(
  ticket: '<value>'
))

unless res.authorization_ticket_info_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                   | Type                                                                                                        | Required                                                                                                    | Description                                                                                                 |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `authorization_ticket_info_request`                                                                         | [Models::Components::AuthorizationTicketInfoRequest](../../models/shared/authorizationticketinforequest.md) | :heavy_check_mark:                                                                                          | N/A                                                                                                         |
| `service_id`                                                                                                | *T.nilable(::String)*                                                                                       | :heavy_minus_sign:                                                                                          | A service ID.                                                                                               |

### Response

**[T.nilable(Models::Operations::AuthorizationTicketInfoPostApiResponse)](../../models/operations/authorizationticketinfopostapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update_ticket

Update Ticket Information

### Example Usage

<!-- UsageSnippet language="ruby" operationID="updateAuthorizationTicket" method="post" path="/api/{serviceId}/auth/authorization/ticket/update" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.authorization_management.update_ticket(authorization_ticket_update_request: Models::Components::AuthorizationTicketUpdateRequest.new(
  ticket: '<value>',
  info: Models::Components::AuthorizationTicketInfo.new
))

unless res.authorization_ticket_update_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                       | Type                                                                                                            | Required                                                                                                        | Description                                                                                                     |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `authorization_ticket_update_request`                                                                           | [Models::Components::AuthorizationTicketUpdateRequest](../../models/shared/authorizationticketupdaterequest.md) | :heavy_check_mark:                                                                                              | N/A                                                                                                             |
| `service_id`                                                                                                    | *T.nilable(::String)*                                                                                           | :heavy_minus_sign:                                                                                              | A service ID.                                                                                                   |

### Response

**[T.nilable(Models::Operations::UpdateAuthorizationTicketResponse)](../../models/operations/updateauthorizationticketresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 429                         | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
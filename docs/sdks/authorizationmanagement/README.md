# AuthorizationManagement
(*authorization.management*)

## Overview

### Available Operations

* [get_ticket_info](#get_ticket_info) - Get Ticket Information
* [update_ticket](#update_ticket) - Update Ticket Information

## get_ticket_info

Get Ticket Information

### Example Usage

<!-- UsageSnippet language="ruby" operationID="authorization_ticket_info_post_api" method="post" path="/api/{serviceId}/auth/authorization/ticket/info" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.authorization.management.get_ticket_info(service_id: '<id>', authorization_ticket_info_request: Models::Components::AuthorizationTicketInfoRequest.new(
  ticket: '<value>',
))

unless res.authorization_ticket_info_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                   | Type                                                                                                        | Required                                                                                                    | Description                                                                                                 |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                | *::String*                                                                                                  | :heavy_check_mark:                                                                                          | A service ID.                                                                                               |
| `authorization_ticket_info_request`                                                                         | [Models::Components::AuthorizationTicketInfoRequest](../../models/shared/authorizationticketinforequest.md) | :heavy_check_mark:                                                                                          | N/A                                                                                                         |

### Response

**[T.nilable(Models::Operations::AuthorizationTicketInfoPostApiResponse)](../../models/operations/authorizationticketinfopostapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## update_ticket

Update Ticket Information

### Example Usage

<!-- UsageSnippet language="ruby" operationID="updateAuthorizationTicket" method="post" path="/api/{serviceId}/auth/authorization/ticket/update" -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.authorization.management.update_ticket(service_id: '<id>', authorization_ticket_update_request: Models::Components::AuthorizationTicketUpdateRequest.new(
  ticket: '<value>',
  info: '<value>',
))

unless res.authorization_ticket_update_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                       | Type                                                                                                            | Required                                                                                                        | Description                                                                                                     |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `service_id`                                                                                                    | *::String*                                                                                                      | :heavy_check_mark:                                                                                              | A service ID.                                                                                                   |
| `authorization_ticket_update_request`                                                                           | [Models::Components::AuthorizationTicketUpdateRequest](../../models/shared/authorizationticketupdaterequest.md) | :heavy_check_mark:                                                                                              | N/A                                                                                                             |

### Response

**[T.nilable(Models::Operations::UpdateAuthorizationTicketResponse)](../../models/operations/updateauthorizationticketresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
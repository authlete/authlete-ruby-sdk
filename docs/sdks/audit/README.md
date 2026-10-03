# Audit

## Overview

### Available Operations

* [get](#get) - Get Audit Logs
* [get_types](#get_types) - Get Audit Log Event Types

## get

Retrieve audit logs as a cursor-paginated list. Results can be filtered by time range, event type,
and organization.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="audit_entries_get_idp_api" method="get" path="/api/audit/entries" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)

req = Models::Operations::AuditEntriesGetIdpApiRequest.new(
  types: [
    'service.create',
  ]
)
res = s.audit.get(request: req)

unless res.audit_entries_get_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                   | Type                                                                                                        | Required                                                                                                    | Description                                                                                                 |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                   | [Models::Operations::AuditEntriesGetIdpApiRequest](../../models/operations/auditentriesgetidpapirequest.md) | :heavy_check_mark:                                                                                          | The request object to use for the request.                                                                  |
| `server_url`                                                                                                | *String*                                                                                                    | :heavy_minus_sign:                                                                                          | An optional server URL to use.                                                                              |

### Response

**[T.nilable(Models::Operations::AuditEntriesGetIdpApiResponse)](../../models/operations/auditentriesgetidpapiresponse.md)**

### Errors

| Error Type               | Status Code              | Content Type             |
| ------------------------ | ------------------------ | ------------------------ |
| Models::Errors::IdpError | 400, 401, 403            | application/json         |
| Models::Errors::IdpError | 500                      | application/json         |
| Errors::APIError         | 4XX, 5XX                 | \*/\*                    |

## get_types

Returns the list of available audit log event types for this environment.

Accessible with a user access token or an organization token that has the
`view_audit_log` permission (e.g. a token created with the `admin` or
`audit_reader` preset).

This endpoint is hosted on the Authlete IdP server (`https://login.authlete.com`),
not on the regional API clusters.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="audit_types_get_idp_api" method="get" path="/api/audit/types" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.audit.get_types

unless res.strings.nil?
  # handle response
end

```

### Parameters

| Parameter                      | Type                           | Required                       | Description                    |
| ------------------------------ | ------------------------------ | ------------------------------ | ------------------------------ |
| `server_url`                   | *String*                       | :heavy_minus_sign:             | An optional server URL to use. |

### Response

**[T.nilable(Models::Operations::AuditTypesGetIdpApiResponse)](../../models/operations/audittypesgetidpapiresponse.md)**

### Errors

| Error Type               | Status Code              | Content Type             |
| ------------------------ | ------------------------ | ------------------------ |
| Models::Errors::IdpError | 400, 401, 403            | application/json         |
| Models::Errors::IdpError | 500                      | application/json         |
| Errors::APIError         | 4XX, 5XX                 | \*/\*                    |
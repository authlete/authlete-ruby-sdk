# Lifecycle

## Overview

### Available Operations

* [get_api_lifecycle_healthcheck](#get_api_lifecycle_healthcheck) - Health Check

## get_api_lifecycle_healthcheck

Perform a health check of the server.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="get_/api/lifecycle/healthcheck" method="get" path="/api/lifecycle/healthcheck" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new

res = s.lifecycle.get_api_lifecycle_healthcheck()

unless res.res.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                | Type                                                                     | Required                                                                 | Description                                                              |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------ | ------------------------------------------------------------------------ | ------------------------------------------------------------------------ |
| `extended`                                                               | *T.nilable(T::Boolean)*                                                  | :heavy_minus_sign:                                                       | If `true`, perform extended health checks (e.g. database connectivity).<br/> |

### Response

**[T.nilable(Models::Operations::GetApiLifecycleHealthcheckResponse)](../../models/operations/getapilifecyclehealthcheckresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |
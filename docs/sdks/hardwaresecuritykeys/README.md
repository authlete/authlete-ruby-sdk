# HardwareSecurityKeys

## Overview

### Available Operations

* [create](#create) - Create Security Key
* [destroy](#destroy) - Delete Security Key
* [retrieve](#retrieve) - Get Security Key
* [list](#list) - List Security Keys

## create

Create Security Key

### Example Usage

<!-- UsageSnippet language="ruby" operationID="hsk_create_api" method="post" path="/api/{serviceId}/hsk/create" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.hardware_security_keys.create(service_id: '<id>', hsk_create_request: Models::Components::HskCreateRequest.new())

unless res.hsk_create_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                       | Type                                                                            | Required                                                                        | Description                                                                     |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `service_id`                                                                    | *::String*                                                                      | :heavy_check_mark:                                                              | A service ID.                                                                   |
| `hsk_create_request`                                                            | [Models::Components::HskCreateRequest](../../models/shared/hskcreaterequest.md) | :heavy_check_mark:                                                              | N/A                                                                             |

### Response

**[T.nilable(Models::Operations::HskCreateApiResponse)](../../models/operations/hskcreateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## destroy

Delete Security Key

### Example Usage

<!-- UsageSnippet language="ruby" operationID="hsk_delete_api" method="delete" path="/api/{serviceId}/hsk/delete/{handle}" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.hardware_security_keys.destroy(service_id: '<id>', handle: '<value>')

unless res.hsk_delete_response.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `service_id`       | *::String*         | :heavy_check_mark: | A service ID.      |
| `handle`           | *::String*         | :heavy_check_mark: | N/A                |

### Response

**[T.nilable(Models::Operations::HskDeleteApiResponse)](../../models/operations/hskdeleteapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## retrieve

Get Security Key

### Example Usage

<!-- UsageSnippet language="ruby" operationID="hsk_get_api" method="get" path="/api/{serviceId}/hsk/get/{handle}" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.hardware_security_keys.retrieve(service_id: '<id>', handle: '<value>')

unless res.hsk_get_response.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `service_id`       | *::String*         | :heavy_check_mark: | A service ID.      |
| `handle`           | *::String*         | :heavy_check_mark: | N/A                |

### Response

**[T.nilable(Models::Operations::HskGetApiResponse)](../../models/operations/hskgetapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## list

List Security Keys

### Example Usage

<!-- UsageSnippet language="ruby" operationID="hsk_get_list_api" method="get" path="/api/{serviceId}/hsk/get/list" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.hardware_security_keys.list(service_id: '<id>')

unless res.hsk_get_list_response.nil?
  # handle response
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `service_id`       | *::String*         | :heavy_check_mark: | A service ID.      |

### Response

**[T.nilable(Models::Operations::HskGetListApiResponse)](../../models/operations/hskgetlistapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
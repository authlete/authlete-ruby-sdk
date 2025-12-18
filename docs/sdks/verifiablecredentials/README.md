# VerifiableCredentials
(*verifiable_credentials*)

## Overview

### Available Operations

* [metadata](#metadata) - Get Verifiable Credential Issuer Metadata
* [jwt_issuer](#jwt_issuer) - Get JWT Issuer Information
* [jwks](#jwks) - Get JSON Web Key Set
* [create_offer](#create_offer) - Create Credential Offer
* [offer_info](#offer_info) - Get Credential Offer Information
* [parse](#parse) - Parse Single Credential
* [issue_response](#issue_response) - Issue Single Credential
* [batch_parse](#batch_parse) - Parse Batch Credentials
* [batch_issue](#batch_issue) - Issue Batch Credentials
* [deferred_parse](#deferred_parse) - Parse Deferred Credential
* [deferred_issue](#deferred_issue) - Issue Deferred Credential

## metadata

Get verifiable credential issuer metadata

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_metadata_api" method="post" path="/api/{serviceId}/vci/metadata" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.metadata(service_id: '<id>', vci_metadata_request: Models::Components::VciMetadataRequest.new(
  pretty: true,
))

unless res.vci_metadata_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `service_id`                                                                        | *::String*                                                                          | :heavy_check_mark:                                                                  | A service ID.                                                                       |
| `vci_metadata_request`                                                              | [Models::Components::VciMetadataRequest](../../models/shared/vcimetadatarequest.md) | :heavy_check_mark:                                                                  | N/A                                                                                 |

### Response

**[T.nilable(Models::Operations::VciMetadataApiResponse)](../../models/operations/vcimetadataapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## jwt_issuer

Get JWT issuer information for VCI

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_jwtissuer_api" method="post" path="/api/{serviceId}/vci/jwtissuer" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.jwt_issuer(service_id: '<id>', vci_jwtissuer_request: Models::Components::VciJwtissuerRequest.new(
  pretty: true,
))

unless res.vci_jwtissuer_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                             | Type                                                                                  | Required                                                                              | Description                                                                           |
| ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| `service_id`                                                                          | *::String*                                                                            | :heavy_check_mark:                                                                    | A service ID.                                                                         |
| `vci_jwtissuer_request`                                                               | [Models::Components::VciJwtissuerRequest](../../models/shared/vcijwtissuerrequest.md) | :heavy_check_mark:                                                                    | N/A                                                                                   |

### Response

**[T.nilable(Models::Operations::VciJwtissuerApiResponse)](../../models/operations/vcijwtissuerapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## jwks

Get JSON Web Key Set for VCI

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_jwks_api" method="post" path="/api/{serviceId}/vci/jwks" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.jwks(service_id: '<id>', vci_jwks_request: Models::Components::VciJwksRequest.new(
  pretty: false,
))

unless res.vci_jwks_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                   | Type                                                                        | Required                                                                    | Description                                                                 |
| --------------------------------------------------------------------------- | --------------------------------------------------------------------------- | --------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| `service_id`                                                                | *::String*                                                                  | :heavy_check_mark:                                                          | A service ID.                                                               |
| `vci_jwks_request`                                                          | [Models::Components::VciJwksRequest](../../models/shared/vcijwksrequest.md) | :heavy_check_mark:                                                          | N/A                                                                         |

### Response

**[T.nilable(Models::Operations::VciJwksApiResponse)](../../models/operations/vcijwksapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## create_offer

Create a verifiable credential offer

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_offer_create_api" method="post" path="/api/{serviceId}/vci/offer/create" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.create_offer(service_id: '<id>', vci_offer_create_request: Models::Components::VciOfferCreateRequest.new())

unless res.vci_offer_create_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `service_id`                                                                              | *::String*                                                                                | :heavy_check_mark:                                                                        | A service ID.                                                                             |
| `vci_offer_create_request`                                                                | [Models::Components::VciOfferCreateRequest](../../models/shared/vcioffercreaterequest.md) | :heavy_check_mark:                                                                        | N/A                                                                                       |

### Response

**[T.nilable(Models::Operations::VciOfferCreateApiResponse)](../../models/operations/vcioffercreateapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## offer_info

Get information about a verifiable credential offer

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_offer_info_api" method="post" path="/api/{serviceId}/vci/offer/info" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.offer_info(service_id: '<id>', vci_offer_info_request: Models::Components::VciOfferInfoRequest.new())

unless res.vci_offer_info_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                             | Type                                                                                  | Required                                                                              | Description                                                                           |
| ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| `service_id`                                                                          | *::String*                                                                            | :heavy_check_mark:                                                                    | A service ID.                                                                         |
| `vci_offer_info_request`                                                              | [Models::Components::VciOfferInfoRequest](../../models/shared/vciofferinforequest.md) | :heavy_check_mark:                                                                    | N/A                                                                                   |

### Response

**[T.nilable(Models::Operations::VciOfferInfoApiResponse)](../../models/operations/vciofferinfoapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## parse

Parse a single verifiable credential

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_single_parse_api" method="post" path="/api/{serviceId}/vci/single/parse" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.parse(service_id: '<id>', vci_single_parse_request: Models::Components::VciSingleParseRequest.new())

unless res.vci_single_parse_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `service_id`                                                                              | *::String*                                                                                | :heavy_check_mark:                                                                        | A service ID.                                                                             |
| `vci_single_parse_request`                                                                | [Models::Components::VciSingleParseRequest](../../models/shared/vcisingleparserequest.md) | :heavy_check_mark:                                                                        | N/A                                                                                       |

### Response

**[T.nilable(Models::Operations::VciSingleParseApiResponse)](../../models/operations/vcisingleparseapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## issue_response

Issue a single verifiable credential

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_single_issue_api" method="post" path="/api/{serviceId}/vci/single/issue" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.issue_response(service_id: '<id>', vci_single_issue_request: Models::Components::VciSingleIssueRequest.new())

unless res.vci_single_issue_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `service_id`                                                                              | *::String*                                                                                | :heavy_check_mark:                                                                        | A service ID.                                                                             |
| `vci_single_issue_request`                                                                | [Models::Components::VciSingleIssueRequest](../../models/shared/vcisingleissuerequest.md) | :heavy_check_mark:                                                                        | N/A                                                                                       |

### Response

**[T.nilable(Models::Operations::VciSingleIssueApiResponse)](../../models/operations/vcisingleissueapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## batch_parse

Parse multiple verifiable credentials in batch

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_batch_parse_api" method="post" path="/api/{serviceId}/vci/batch/parse" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.batch_parse(service_id: '<id>', vci_batch_parse_request: Models::Components::VciBatchParseRequest.new())

unless res.vci_batch_parse_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                               | Type                                                                                    | Required                                                                                | Description                                                                             |
| --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| `service_id`                                                                            | *::String*                                                                              | :heavy_check_mark:                                                                      | A service ID.                                                                           |
| `vci_batch_parse_request`                                                               | [Models::Components::VciBatchParseRequest](../../models/shared/vcibatchparserequest.md) | :heavy_check_mark:                                                                      | N/A                                                                                     |

### Response

**[T.nilable(Models::Operations::VciBatchParseApiResponse)](../../models/operations/vcibatchparseapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## batch_issue

Issue multiple verifiable credentials in batch

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_batch_issue_api" method="post" path="/api/{serviceId}/vci/batch/issue" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.batch_issue(service_id: '<id>', vci_batch_issue_request: Models::Components::VciBatchIssueRequest.new())

unless res.vci_batch_issue_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                               | Type                                                                                    | Required                                                                                | Description                                                                             |
| --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| `service_id`                                                                            | *::String*                                                                              | :heavy_check_mark:                                                                      | A service ID.                                                                           |
| `vci_batch_issue_request`                                                               | [Models::Components::VciBatchIssueRequest](../../models/shared/vcibatchissuerequest.md) | :heavy_check_mark:                                                                      | N/A                                                                                     |

### Response

**[T.nilable(Models::Operations::VciBatchIssueApiResponse)](../../models/operations/vcibatchissueapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## deferred_parse

Parse a deferred verifiable credential

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_deferred_parse_api" method="post" path="/api/{serviceId}/vci/deferred/parse" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.deferred_parse(service_id: '<id>', vci_deferred_parse_request: Models::Components::VciDeferredParseRequest.new())

unless res.vci_deferred_parse_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `service_id`                                                                                  | *::String*                                                                                    | :heavy_check_mark:                                                                            | A service ID.                                                                                 |
| `vci_deferred_parse_request`                                                                  | [Models::Components::VciDeferredParseRequest](../../models/shared/vcideferredparserequest.md) | :heavy_check_mark:                                                                            | N/A                                                                                           |

### Response

**[T.nilable(Models::Operations::VciDeferredParseApiResponse)](../../models/operations/vcideferredparseapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## deferred_issue

Issue a deferred verifiable credential

### Example Usage

<!-- UsageSnippet language="ruby" operationID="vci_deferred_issue_api" method="post" path="/api/{serviceId}/vci/deferred/issue" -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.verifiable_credentials.deferred_issue(service_id: '<id>', vci_deferred_issue_request: Models::Components::VciDeferredIssueRequest.new())

unless res.vci_deferred_issue_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `service_id`                                                                                  | *::String*                                                                                    | :heavy_check_mark:                                                                            | A service ID.                                                                                 |
| `vci_deferred_issue_request`                                                                  | [Models::Components::VciDeferredIssueRequest](../../models/shared/vcideferredissuerequest.md) | :heavy_check_mark:                                                                            | N/A                                                                                           |

### Response

**[T.nilable(Models::Operations::VciDeferredIssueApiResponse)](../../models/operations/vcideferredissueapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
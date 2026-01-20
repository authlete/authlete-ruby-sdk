# Authlete Ruby SDK

Developer-friendly & type-safe Ruby SDK specifically catered to leverage *Authlete* API.

<div align="left">
    <a href="https://www.speakeasy.com/?utm_source=authlete&utm_campaign=ruby"><img src="https://custom-icon-badges.demolab.com/badge/-Built%20By%20Speakeasy-212015?style=for-the-badge&logoColor=FBE331&logo=speakeasy&labelColor=545454" /></a>
    <a href="https://opensource.org/licenses/MIT">
        <img src="https://img.shields.io/badge/License-MIT-blue.svg" style="width: 100px; height: 28px;" />
    </a>
    <br> </br>
</div>

> [!IMPORTANT]
> This is a beta SDK.

## 🎓 Tutorials

If you're new to Authlete or want to see sample implementations, these resources will help you get started:

- [🚀 Getting Started with Authlete](https://www.authlete.com/developers/getting_started/)
- [🔑 From Sign-Up to the First API Request](https://www.authlete.com/developers/tutorial/signup/)

## 🛠 Contact Us

If you have any questions or need assistance, our team is here to help:

- [Contact Page](https://www.authlete.com/contact/)
<!-- End Summary [summary] -->

<!-- Start Table of Contents [toc] -->

## Table of Contents
<!-- $toc-max-depth=2 -->
  * [SDK Installation](#sdk-installation)
  * [Access Tokens](#access-tokens)
  * [Quick Start](#quick-start)
  * [SDK Example Usage](#sdk-example-usage)
  * [Authentication](#authentication)
  * [Available Resources and Operations](#available-resources-and-operations)
  * [Error Handling](#error-handling)
  * [Server Selection](#server-selection)
* [Development](#development)
  * [Maturity](#maturity)
  * [Contributions](#contributions)

<!-- End Table of Contents [toc] -->

<!-- Start SDK Installation [installation] -->
## SDK Installation

The SDK can be installed using [RubyGems](https://rubygems.org/):

```bash
gem install authlete_ruby_sdk
```
<!-- End SDK Installation [installation] -->

## Access Tokens

You need to pass a valid access token to be able to use any resource or operation. Refer to [Creating an Access Token](https://www.authlete.com/developers/tutorial/signup/) to learn how to create one.

Authlete supports two types of access tokens:

- **Service Access Token** - Scoped to a single service (authorization server instance). Create from **Service Settings** → **Access Tokens** in the [Authlete Console](https://console.authlete.com).
- **Organization Token** - Scoped to your entire organization, allowing access to all services. Create from **[Organization Settings](https://www.authlete.com/developers/terraform/starting/#setting-your-environment)** → **Access Tokens**.

Make sure that you create a token with the correct scope. If you face permission (403) errors when already sending a token, it can be one of the following problems:

- The token you are using has expired. Check the expiry date in the Authlete Console.
- The token does not have access to the correct scope, either not the right service or it does not have account level access.
- The resource or operation you are trying to use is not available for that service tier. For example, some features are Enterprise-only and you may be using a token for a service on a different plan.

## Quick Start

```ruby
require "authlete_ruby_sdk"

# Initialize the Authlete client (following Stripe's pattern)
authlete_client = Authlete::Client.new(bearer: "<YOUR_BEARER_TOKEN>")

# Retrieve a service
begin
  response = authlete_client.services.retrieve(service_id: "<service_id>")
  puts response.service
rescue Authlete::Models::Errors::ResultError => e
  # Handle Authlete-specific errors
  puts "Authlete error: #{e.message}"
  raise
rescue Authlete::Models::Errors::APIError => e
  # Handle general API errors
  puts "API error: #{e.message}"
  raise
end

# List OAuth clients
response = authlete_client.clients.list(service_id: "<service_id>")
response.clients.each { |oauth_client| puts oauth_client.client_name }

# Process an authorization request
response = authlete_client.authorization.process_request(
  service_id: "<service_id>",
  parameters: "response_type=code&client_id=..."
)
```

<!-- Start SDK Example Usage [usage] -->
## SDK Example Usage

### Example

```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
authlete_client = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

response = authlete_client.services.retrieve(service_id: '<id>')

unless response.service.nil?
  # handle response
end

```
<!-- End SDK Example Usage [usage] -->

<!-- Start Authentication [security] -->
## Authentication

### Per-Client Security Schemes

This SDK supports the following security scheme globally:

| Name     | Type | Scheme      |
| -------- | ---- | ----------- |
| `bearer` | http | HTTP Bearer |

To authenticate with the API the `bearer` parameter must be set when initializing the SDK client instance. For example:
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
authlete_client = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

response = authlete_client.services.retrieve(service_id: '<id>')

unless response.service.nil?
  # handle response
end

```
<!-- End Authentication [security] -->

<!-- Start Available Resources and Operations [operations] -->
## Available Resources and Operations

<details open>
<summary>Available methods</summary>

### [Authorization](docs/sdks/authorization/README.md)

* [process_request](docs/sdks/authorization/README.md#process_request) - Process Authorization Request
* [fail_request](docs/sdks/authorization/README.md#fail_request) - Fail Authorization Request
* [issue_response](docs/sdks/authorization/README.md#issue_response) - Issue Authorization Response

### [AuthorizationManagement](docs/sdks/authorizationmanagement/README.md)

* [ticket_info](docs/sdks/authorizationmanagement/README.md#ticket_info) - Get Ticket Information
* [update_ticket](docs/sdks/authorizationmanagement/README.md#update_ticket) - Update Ticket Information

### [Ciba](docs/sdks/ciba/README.md)

* [process_authentication](docs/sdks/ciba/README.md#process_authentication) - Process Backchannel Authentication Request
* [issue_response](docs/sdks/ciba/README.md#issue_response) - Issue Backchannel Authentication Response
* [fail_request](docs/sdks/ciba/README.md#fail_request) - Fail Backchannel Authentication Request
* [complete_request](docs/sdks/ciba/README.md#complete_request) - Complete Backchannel Authentication

### [ClientManagement](docs/sdks/clientmanagement/README.md)

* [update_lock_flag](docs/sdks/clientmanagement/README.md#update_lock_flag) - Update Client Lock
* [refresh_secret](docs/sdks/clientmanagement/README.md#refresh_secret) - Rotate Client Secret
* [update_secret](docs/sdks/clientmanagement/README.md#update_secret) - Update Client Secret
* [authorizations](docs/sdks/clientmanagement/README.md#authorizations) - Get Authorized Applications
* [update_authorizations](docs/sdks/clientmanagement/README.md#update_authorizations) - Update Client Tokens
* [destroy_authorizations](docs/sdks/clientmanagement/README.md#destroy_authorizations) - Delete Client Tokens
* [granted_scopes](docs/sdks/clientmanagement/README.md#granted_scopes) - Get Granted Scopes
* [destroy_granted_scopes](docs/sdks/clientmanagement/README.md#destroy_granted_scopes) - Delete Granted Scopes
* [requestable_scopes](docs/sdks/clientmanagement/README.md#requestable_scopes) - Get Requestable Scopes
* [update_requestable_scopes](docs/sdks/clientmanagement/README.md#update_requestable_scopes) - Update Requestable Scopes
* [destroy_requestable_scopes](docs/sdks/clientmanagement/README.md#destroy_requestable_scopes) - Delete Requestable Scopes

### [Clients](docs/sdks/clients/README.md)

* [retrieve](docs/sdks/clients/README.md#retrieve) - Get Client
* [list](docs/sdks/clients/README.md#list) - List Clients
* [create](docs/sdks/clients/README.md#create) - Create Client
* [update](docs/sdks/clients/README.md#update) - Update Client
* [update_form](docs/sdks/clients/README.md#update_form) - Update Client
* [destroy](docs/sdks/clients/README.md#destroy) - Delete Client ⚡

### [DeviceFlow](docs/sdks/deviceflow/README.md)

* [authorization](docs/sdks/deviceflow/README.md#authorization) - Process Device Authorization Request
* [verification](docs/sdks/deviceflow/README.md#verification) - Process Device Verification Request
* [complete_request](docs/sdks/deviceflow/README.md#complete_request) - Complete Device Authorization

### [DynamicClientRegistration](docs/sdks/dynamicclientregistration/README.md)

* [register](docs/sdks/dynamicclientregistration/README.md#register) - Register Client
* [retrieve](docs/sdks/dynamicclientregistration/README.md#retrieve) - Get Client
* [update](docs/sdks/dynamicclientregistration/README.md#update) - Update Client
* [destroy](docs/sdks/dynamicclientregistration/README.md#destroy) - Delete Client

### [Federation](docs/sdks/federation/README.md)

* [configuration](docs/sdks/federation/README.md#configuration) - Process Entity Configuration Request
* [registration](docs/sdks/federation/README.md#registration) - Process Federation Registration Request

### [GrantManagement](docs/sdks/grantmanagement/README.md)

* [process_request](docs/sdks/grantmanagement/README.md#process_request) - Process Grant Management Request

### [HardwareSecurityKeys](docs/sdks/hardwaresecuritykeys/README.md)

* [create](docs/sdks/hardwaresecuritykeys/README.md#create) - Create Security Key
* [destroy](docs/sdks/hardwaresecuritykeys/README.md#destroy) - Delete Security Key
* [retrieve](docs/sdks/hardwaresecuritykeys/README.md#retrieve) - Get Security Key
* [list](docs/sdks/hardwaresecuritykeys/README.md#list) - List Security Keys

### [Introspection](docs/sdks/introspection/README.md)

* [process_request](docs/sdks/introspection/README.md#process_request) - Process Introspection Request
* [standard_process](docs/sdks/introspection/README.md#standard_process) - Process OAuth 2.0 Introspection Request

### [JoseObject](docs/sdks/joseobject/README.md)

* [jose_verify_api](docs/sdks/joseobject/README.md#jose_verify_api) - Verify JOSE

### [JWKSetEndpoint](docs/sdks/jwksetendpoint/README.md)

* [service_jwks_get_api](docs/sdks/jwksetendpoint/README.md#service_jwks_get_api) - Get JWK Set

### [NativeSso](docs/sdks/nativesso/README.md)

* [process_request](docs/sdks/nativesso/README.md#process_request) - Native SSO Processing
* [logout](docs/sdks/nativesso/README.md#logout) - Native SSO Logout Processing

### [PushedAuthorization](docs/sdks/pushedauthorization/README.md)

* [create](docs/sdks/pushedauthorization/README.md#create) - Process Pushed Authorization Request

### [Revocation](docs/sdks/revocation/README.md)

* [process_request](docs/sdks/revocation/README.md#process_request) - Process Revocation Request

### [Services](docs/sdks/services/README.md)

* [retrieve](docs/sdks/services/README.md#retrieve) - Get Service
* [list](docs/sdks/services/README.md#list) - List Services
* [create](docs/sdks/services/README.md#create) - Create Service
* [update](docs/sdks/services/README.md#update) - Update Service
* [destroy](docs/sdks/services/README.md#destroy) - Delete Service ⚡
* [configuration](docs/sdks/services/README.md#configuration) - Get Service Configuration

### [TokenManagement](docs/sdks/tokenmanagement/README.md)

* [reissue_id_token](docs/sdks/tokenmanagement/README.md#reissue_id_token) - Reissue ID Token
* [list](docs/sdks/tokenmanagement/README.md#list) - List Issued Tokens
* [create](docs/sdks/tokenmanagement/README.md#create) - Create Access Token
* [update](docs/sdks/tokenmanagement/README.md#update) - Update Access Token
* [destroy](docs/sdks/tokenmanagement/README.md#destroy) - Delete Access Token
* [revoke](docs/sdks/tokenmanagement/README.md#revoke) - Revoke Access Token

### [Tokens](docs/sdks/tokens/README.md)

* [process_request](docs/sdks/tokens/README.md#process_request) - Process Token Request
* [fail_request](docs/sdks/tokens/README.md#fail_request) - Fail Token Request
* [issue_response](docs/sdks/tokens/README.md#issue_response) - Issue Token Response

### [Userinfo](docs/sdks/userinfo/README.md)

* [process_request](docs/sdks/userinfo/README.md#process_request) - Process UserInfo Request
* [issue_response](docs/sdks/userinfo/README.md#issue_response) - Issue UserInfo Response

### [VerifiableCredentials](docs/sdks/verifiablecredentials/README.md)

* [metadata](docs/sdks/verifiablecredentials/README.md#metadata) - Get Verifiable Credential Issuer Metadata
* [jwt_issuer](docs/sdks/verifiablecredentials/README.md#jwt_issuer) - Get JWT Issuer Information
* [jwks](docs/sdks/verifiablecredentials/README.md#jwks) - Get JSON Web Key Set
* [create_offer](docs/sdks/verifiablecredentials/README.md#create_offer) - Create Credential Offer
* [offer_info](docs/sdks/verifiablecredentials/README.md#offer_info) - Get Credential Offer Information
* [parse](docs/sdks/verifiablecredentials/README.md#parse) - Parse Single Credential
* [issue_response](docs/sdks/verifiablecredentials/README.md#issue_response) - Issue Single Credential
* [batch_parse](docs/sdks/verifiablecredentials/README.md#batch_parse) - Parse Batch Credentials
* [batch_issue](docs/sdks/verifiablecredentials/README.md#batch_issue) - Issue Batch Credentials
* [deferred_parse](docs/sdks/verifiablecredentials/README.md#deferred_parse) - Parse Deferred Credential
* [deferred_issue](docs/sdks/verifiablecredentials/README.md#deferred_issue) - Issue Deferred Credential

</details>
<!-- End Available Resources and Operations [operations] -->

<!-- Start Error Handling [errors] -->
## Error Handling

Handling errors in this SDK should largely match your expectations. All operations return a response object or raise an error.

By default an API error will raise a `Errors::APIError`, which has the following properties:

| Property       | Type                                    | Description           |
|----------------|-----------------------------------------|-----------------------|
| `message`     | *string*                                 | The error message     |
| `status_code`  | *int*                                   | The HTTP status code  |
| `raw_response` | *Faraday::Response*                     | The raw HTTP response |
| `body`        | *string*                                 | The response content  |

When custom error responses are specified for an operation, the SDK may also throw their associated exception. You can refer to respective *Errors* tables in SDK docs for more details on possible exception types for each operation. For example, the `retrieve` method throws the following exceptions:

| Error Type                  | Status Code   | Content Type     |
| --------------------------- | ------------- | ---------------- |
| Models::Errors::ResultError | 400, 401, 403 | application/json |
| Models::Errors::ResultError | 500           | application/json |
| Errors::APIError            | 4XX, 5XX      | \*/\*            |

### Example

```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
authlete_client = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

begin
    response = authlete_client.services.retrieve(service_id: '<id>')

    unless response.service.nil?
      # handle response
    end
rescue Models::Errors::ResultError => e
  # handle e.container data
  raise e
rescue Models::Errors::ResultError => e
  # handle e.container data
  raise e
rescue Errors::APIError => e
  # handle default exception
  raise e
end

```
<!-- End Error Handling [errors] -->

<!-- Start Server Selection [server] -->
## Server Selection

### Select Server by Index

You can override the default server globally by passing a server index to the `server_idx (Integer)` optional parameter when initializing the SDK client instance. The selected server will then be used as the default on the operations that use it. This table lists the indexes associated with the available servers:

| #   | Server                    | Description         |
| --- | ------------------------- | ------------------- |
| 0   | `https://us.authlete.com` | 🇺🇸 US Cluster     |
| 1   | `https://jp.authlete.com` | 🇯🇵 Japan Cluster  |
| 2   | `https://eu.authlete.com` | 🇪🇺 Europe Cluster |
| 3   | `https://br.authlete.com` | 🇧🇷 Brazil Cluster |

#### Example

```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
authlete_client = ::Authlete::Client.new(
      server_idx: 3,
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

response = authlete_client.services.retrieve(service_id: '<id>')

unless response.service.nil?
  # handle response
end

```

### Override Server URL Per-Client

The default server can also be overridden globally by passing a URL to the `server_url (String)` optional parameter when initializing the SDK client instance. For example:
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
authlete_client = ::Authlete::Client.new(
      server_url: 'https://br.authlete.com',
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

response = authlete_client.services.retrieve(service_id: '<id>')

unless response.service.nil?
  # handle response
end

```
<!-- End Server Selection [server] -->

<!-- Placeholder for Future Speakeasy SDK Sections -->

# Development

## Maturity

This SDK is in beta, and there may be breaking changes between versions without a major version update. Therefore, we recommend pinning usage
to a specific package version. This way, you can install the same version each time without breaking changes unless you are intentionally
looking for the latest version.

## Contributions

While we value open-source contributions to this SDK, this library is generated programmatically. Any manual changes added to internal files will be overwritten on the next generation. 
We look forward to hearing your feedback. Feel free to open a PR or an issue with a proof of concept and we'll do our best to include it in a future release. 

### SDK Created by [Speakeasy](https://www.speakeasy.com/?utm_source=authlete&utm_campaign=ruby)

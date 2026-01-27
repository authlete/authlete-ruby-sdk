# Authlete Ruby SDK

Developer-friendly & type-safe Ruby SDK specifically catered to leverage *Authlete* API v3.0 and forward.

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
* [Authlete Ruby SDK](#authlete-ruby-sdk)
  * [SDK Installation](#sdk-installation)
    * [Prerequisites](#prerequisites)
    * [Install the SDK](#install-the-sdk)
  * [Access Tokens](#access-tokens)
    * [Troubleshooting Token Issues](#troubleshooting-token-issues)
  * [Quick Start](#quick-start)
  * [SDK Example Usage](#sdk-example-usage)
  * [Authentication](#authentication)
    * [Per-Client Security Schemes](#per-client-security-schemes)
  * [Available Resources and Operations](#available-resources-and-operations)
  * [Error Handling](#error-handling)
    * [Example](#example-1)
  * [Troubleshooting](#troubleshooting)
    * [Common Issues](#common-issues)
    * [Service ID vs API Key](#service-id-vs-api-key)
  * [Server Selection](#server-selection)
    * [Configure Server URL (Recommended)](#configure-server-url-recommended)
    * [Alternative: Select Server by Index](#alternative-select-server-by-index)
* [Development](#development)
  * [Maturity](#maturity)
  * [Contributions](#contributions)

<!-- End Table of Contents [toc] -->

<!-- Start SDK Installation [installation] -->
## SDK Installation

### Prerequisites

- **Ruby Version**: Ruby >= 3.2.0 is required
  ```bash
  ruby --version  # Check your Ruby version
  ```

### Install the SDK

The SDK can be installed using [RubyGems](https://rubygems.org/):

```bash
gem install authlete_ruby_sdk
```

Or add it to your `Gemfile`:

```ruby
gem 'authlete_ruby_sdk', '~> 0.0.2.beta'
```

Then run:
```bash
bundle install
```
<!-- End SDK Installation [installation] -->

## Access Tokens

You need to pass a valid access token to be able to use any resource or operation. The `bearer` parameter required when initializing the SDK client must be one of the following two token types:

- **Service Access Token** - Scoped to a single service (authorization server instance). Use when you need to access a specific service only. Create from **Service Settings** → **Access Tokens** in the [Authlete Console](https://console.authlete.com).
- **Organization Token** - Scoped to your entire organization, allowing access to all services. Use when you need to access multiple services or perform organization-level operations. Create from **[Organization Settings](https://www.authlete.com/developers/terraform/starting/#setting-your-environment)** → **Access Tokens**.

Refer to [Creating an Access Token](https://www.authlete.com/developers/tutorial/signup/) to learn how to create one.

### Troubleshooting Token Issues

If you face permission (403) errors when already sending a token, it can be one of the following problems:

- The token you are using has expired. Check the expiry date in the Authlete Console.
- You're using the wrong token type (e.g., using a Service Token to access a different service, or using a Service Token when you need organization-level access).
- The resource or operation you are trying to use is not available for that service tier. For example, some features are Enterprise-only and you may be using a token for a service on a different plan.

## Quick Start

**Important:** You must specify which Authlete server to use when initializing the client. If omitted, it defaults to the US server (`server_idx: 0`).

```ruby
require "authlete_ruby_sdk"

# Create an alias for cleaner code (optional but recommended)
Models = ::Authlete::Models

# Initialize the Authlete client
# Available servers: https://us.authlete.com, https://jp.authlete.com, 
#                    https://eu.authlete.com, https://br.authlete.com
authlete_client = ::Authlete::Client.new(
  bearer: "<YOUR_BEARER_TOKEN>",  # Service Access Token or Organization Token (see Access Tokens section)
  server_url: "https://us.authlete.com"  # Required: Specify your server
)

# Example 1: Retrieve a service
begin
  response = authlete_client.services.retrieve(service_id: "<service_id>")
  
  unless response.service.nil?
    service = response.service
    puts "Service Name: #{service.service_name}"
    puts "Service ID (api_key): #{service.api_key}"
    puts "Issuer: #{service.issuer}"
  end
rescue Models::Errors::ResultError => e
  # Handle Authlete-specific errors
  puts "Authlete error: #{e.result_code} - #{e.result_message}"
rescue Models::Errors::APIError => e
  # Handle HTTP errors
  puts "API error: HTTP #{e.status_code} - #{e.message}"
end

# Example 2: List OAuth clients
begin
  response = authlete_client.clients.list(service_id: "<service_id>")
  
  if response.client_get_list_response && response.client_get_list_response.clients
    response.client_get_list_response.clients.each do |oauth_client|
      puts "Client: #{oauth_client.client_name} (ID: #{oauth_client.client_id})"
    end
  end
rescue Models::Errors::ResultError => e
  puts "Error: #{e.result_message}"
end

# Example 3: Process an authorization request
begin
  response = authlete_client.authorization.process_request(
    service_id: "<service_id>",
    authorization_request: Models::Components::AuthorizationRequest.new(
      parameters: "response_type=code&client_id=<client_id>&redirect_uri=<redirect_uri>"
    )
  )
  
  if response.authorization_response
    puts "Action: #{response.authorization_response.action}"
    puts "Ticket: #{response.authorization_response.ticket}" if response.authorization_response.ticket
  end
rescue Models::Errors::ResultError => e
  puts "Error: #{e.result_message}"
end
```

> **Note:** Do not include `/api` in the `server_url` - the SDK appends it automatically. The `service_id` parameter uses the service's `api_key` value.

<!-- Start SDK Example Usage [usage] -->
## SDK Example Usage

See the [Quick Start](#quick-start) section above for comprehensive examples showing how to initialize the client and make API calls with proper error handling.

For additional examples and detailed API documentation, see the [Available Resources and Operations](#available-resources-and-operations) section below.
<!-- End SDK Example Usage [usage] -->

<!-- Start Authentication [security] -->
## Authentication

### Per-Client Security Schemes

This SDK supports the following security scheme globally:

| Name     | Type | Scheme      |
| -------- | ---- | ----------- |
| `bearer` | http | HTTP Bearer |

To authenticate with the API, both the `bearer` parameter and `server_url` should be set when initializing the SDK client instance. For example:
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
authlete_client = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',  # Service Access Token or Organization Token (see Access Tokens section)
      server_url: 'https://us.authlete.com'  # Required: Specify your server
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
      server_url: 'https://us.authlete.com'  # Specify your server
    )

begin
    response = authlete_client.services.retrieve(service_id: '<id>')

    unless response.service.nil?
      # handle response
    end
rescue Models::Errors::ResultError => e
  # handle Authlete-specific errors
  puts "Result Code: #{e.result_code}"
  puts "Result Message: #{e.result_message}"
  raise e
rescue Errors::APIError => e
  # handle HTTP errors
  puts "Status Code: #{e.status_code}"
  puts "Body: #{e.body}"
  raise e
end

```
<!-- End Error Handling [errors] -->

## Troubleshooting

### Common Issues

#### "cannot load such file -- sorbet-runtime"
**Problem:** Ruby version is too old or dependencies not installed.

**Solution:**
- Ensure Ruby >= 3.2.0 is installed: `ruby --version`
- Install dependencies: `gem install sorbet-runtime faraday faraday-multipart faraday-retry base64`

#### "The access token presented is not valid" (A458101)
**Problem:** Bearer token is invalid, expired, or lacks permissions.

**Solution:**
- Verify your bearer token is correct and matches the token type you need (see [Access Tokens](#access-tokens) section)
- Check if token has expired in the Authlete Console
- Ensure you're using the correct token type (Service Token vs Organization Token)
- Verify you're using the correct server (token may be valid for a different region)

#### "Service not found" (A458203)
**Problem:** Service ID doesn't exist on the specified server.

**Solution:**
- Verify the service ID (`api_key`) is correct
- Check if you're using the correct server (service may be on a different region)
- List services to find available service IDs:
  ```ruby
  response = client.services.list()
  response.service_get_list_response.services.each do |s|
    puts "Service ID: #{s.api_key}, Name: #{s.service_name}"
  end
  ```

#### "404 Not Found"
**Problem:** Base URL includes `/api` suffix or incorrect endpoint.

**Solution:**
- Remove `/api` from `server_url` - use `https://us.authlete.com` not `https://us.authlete.com/api`
- Verify the endpoint path is correct

#### "already initialized constant Authlete::SERVERS" (Warning)
**Problem:** SDK is being loaded multiple times.

**Solution:** This is just a warning and can be ignored. It doesn't affect functionality.

### Service ID vs API Key

When calling `services.retrieve(service_id: ...)`, use the service's `api_key` value as the `service_id` parameter:

```ruby
# The service_id parameter uses the api_key value
response = client.services.retrieve(service_id: '715948317')  # api_key value
service = response.service
puts service.api_key  # Returns: 715948317
```

<!-- Start Server Selection [server] -->
## Server Selection

**Important:** You must configure the server URL when initializing the SDK client. If omitted, it defaults to the US server (`server_idx: 0`), which may not be the correct server for your services.

### Configure Server URL (Recommended)

Specify the server URL directly when creating the client instance. All operations performed through that client will use the specified server.

**Available Servers:**
- 🇺🇸 **US**: `https://us.authlete.com`
- 🇯🇵 **Japan**: `https://jp.authlete.com`
- 🇪🇺 **Europe**: `https://eu.authlete.com`
- 🇧🇷 **Brazil**: `https://br.authlete.com`

#### Example

```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
authlete_client = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
      server_url: 'https://us.authlete.com'  # Specify your server
    )

response = authlete_client.services.retrieve(service_id: '<id>')

unless response.service.nil?
  # handle response
end

```

> **Note:** Do not include `/api` in the `server_url` - the SDK appends it automatically.

### Alternative: Select Server by Index

You can also specify the server using a numeric index instead of the full URL:

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
      server_idx: 0,  # 0 = US, 1 = Japan, 2 = Europe, 3 = Brazil
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

response = authlete_client.services.retrieve(service_id: '<id>')

unless response.service.nil?
  # handle response
end

```

**Recommendation:** Use `server_url` instead of `server_idx` for better clarity and to avoid confusion about which server you're using.
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

# authlete

Developer-friendly & type-safe Ruby SDK specifically catered to leverage *authlete* API.

<div align="left">
    <a href="https://www.speakeasy.com/?utm_source=authlete&utm_campaign=ruby"><img src="https://custom-icon-badges.demolab.com/badge/-Built%20By%20Speakeasy-212015?style=for-the-badge&logoColor=FBE331&logo=speakeasy&labelColor=545454" /></a>
    <a href="https://opensource.org/licenses/MIT">
        <img src="https://img.shields.io/badge/License-MIT-blue.svg" style="width: 100px; height: 28px;" />
    </a>
</div>


<br /><br />
> [!IMPORTANT]
> This SDK is not yet ready for production use. To complete setup please follow the steps outlined in your [workspace](https://app.speakeasy.com/org/authlete/sdk-workspace). Delete this section before > publishing to a package manager.

<!-- Start Summary [summary] -->
## Summary

Authlete API: Welcome to the **Authlete API documentation**. Authlete is an **API-first service** where every aspect of the 
platform is configurable via API. This documentation will help you authenticate and integrate with Authlete to 
build powerful OAuth 2.0 and OpenID Connect servers. 🚀

At a high level, the Authlete API is grouped into two categories:

- **Management APIs**: Enable you to manage services and clients. 🔧
- **Runtime APIs**: Allow you to build your own Authorization Servers or Verifiable Credential (VC) issuers. 🔐

## 🌐 API Servers

Authlete is a global service with clusters available in multiple regions across the world:

- 🇺🇸 **US**: `https://us.authlete.com`
- 🇯🇵 **Japan**: `https://jp.authlete.com`
- 🇪🇺 **Europe**: `https://eu.authlete.com`
- 🇧🇷 **Brazil**: `https://br.authlete.com`

Our customers can host their data in the region that best meets their requirements.

## 🔑 Authentication

All API endpoints are secured using **Bearer token authentication**. You must include an access token in every request:

```
Authorization: Bearer YOUR_ACCESS_TOKEN
```

### Getting Your Access Token

Authlete supports two types of access tokens:

**Service Access Token** - Scoped to a single service (authorization server instance)

1. Log in to [Authlete Console](https://console.authlete.com)
2. Navigate to your service → **Settings** → **Access Tokens**
3. Click **Create Token** and select permissions (e.g., `service.read`, `client.write`)
4. Copy the generated token

**Organization Token** - Scoped to your entire organization

1. Log in to [Authlete Console](https://console.authlete.com)
2. Navigate to **Organization Settings** → **Access Tokens**
3. Click **Create Token** and select org-level permissions
4. Copy the generated token

> ⚠️ **Important Note**: Tokens inherit the permissions of the account that creates them. Service tokens can only 
> access their specific service, while organization tokens can access all services within your org.

### Token Security Best Practices

- **Never commit tokens to version control** - Store in environment variables or secure secret managers
- **Rotate regularly** - Generate new tokens periodically and revoke old ones
- **Scope appropriately** - Request only the permissions your application needs
- **Revoke unused tokens** - Delete tokens you're no longer using from the console

### Quick Test

Verify your token works with a simple API call:

```bash
curl -X GET https://us.authlete.com/api/service/get/list \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

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
* [authlete](#authlete)
  * [🌐 API Servers](#api-servers)
  * [🔑 Authentication](#authentication)
  * [🎓 Tutorials](#tutorials)
  * [🛠 Contact Us](#contact-us)
  * [SDK Installation](#sdk-installation)
  * [SDK Example Usage](#sdk-example-usage)
  * [Authentication](#authentication-1)
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
gem install specific_install
gem specific_install https://github.com/authlete/authlete-ruby-sdk 
```
<!-- End SDK Installation [installation] -->

<!-- Start SDK Example Usage [usage] -->
## SDK Example Usage

### Example

```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.service.get(service_id: '<id>')

unless res.service.nil?
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
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.service.get(service_id: '<id>')

unless res.service.nil?
  # handle response
end

```
<!-- End Authentication [security] -->

<!-- Start Available Resources and Operations [operations] -->
## Available Resources and Operations

<details open>
<summary>Available methods</summary>


### [authorization](docs/sdks/authorization/README.md)

* [process_request](docs/sdks/authorization/README.md#process_request) - Process Authorization Request
* [fail](docs/sdks/authorization/README.md#fail) - Fail Authorization Request
* [issue](docs/sdks/authorization/README.md#issue) - Issue Authorization Response

#### [authorization.management](docs/sdks/authorizationmanagement/README.md)

* [get_ticket_info](docs/sdks/authorizationmanagement/README.md#get_ticket_info) - Get Ticket Information
* [update_ticket](docs/sdks/authorizationmanagement/README.md#update_ticket) - Update Ticket Information

### [ciba](docs/sdks/ciba/README.md)

* [process_authentication](docs/sdks/ciba/README.md#process_authentication) - Process Backchannel Authentication Request
* [issue](docs/sdks/ciba/README.md#issue) - Issue Backchannel Authentication Response
* [fail](docs/sdks/ciba/README.md#fail) - Fail Backchannel Authentication Request
* [complete](docs/sdks/ciba/README.md#complete) - Complete Backchannel Authentication

### [client](docs/sdks/client/README.md)

* [get](docs/sdks/client/README.md#get) - Get Client
* [list](docs/sdks/client/README.md#list) - List Clients
* [create](docs/sdks/client/README.md#create) - Create Client
* [update](docs/sdks/client/README.md#update) - Update Client
* [delete](docs/sdks/client/README.md#delete) - Delete Client ⚡

#### [client.management](docs/sdks/clientmanagement/README.md)

* [update_lock_flag](docs/sdks/clientmanagement/README.md#update_lock_flag) - Update Client Lock
* [refresh_secret](docs/sdks/clientmanagement/README.md#refresh_secret) - Rotate Client Secret
* [update_secret](docs/sdks/clientmanagement/README.md#update_secret) - Update Client Secret
* [list_authorizations](docs/sdks/clientmanagement/README.md#list_authorizations) - Get Authorized Applications
* [update_authorizations](docs/sdks/clientmanagement/README.md#update_authorizations) - Update Client Tokens
* [delete_authorizations](docs/sdks/clientmanagement/README.md#delete_authorizations) - Delete Client Tokens
* [get_granted_scopes](docs/sdks/clientmanagement/README.md#get_granted_scopes) - Get Granted Scopes
* [delete_granted_scopes](docs/sdks/clientmanagement/README.md#delete_granted_scopes) - Delete Granted Scopes
* [get_requestable_scopes](docs/sdks/clientmanagement/README.md#get_requestable_scopes) - Get Requestable Scopes
* [update_requestable_scopes](docs/sdks/clientmanagement/README.md#update_requestable_scopes) - Update Requestable Scopes
* [delete_requestable_scopes](docs/sdks/clientmanagement/README.md#delete_requestable_scopes) - Delete Requestable Scopes

### [device_flow](docs/sdks/deviceflow/README.md)

* [authorization](docs/sdks/deviceflow/README.md#authorization) - Process Device Authorization Request
* [verification](docs/sdks/deviceflow/README.md#verification) - Process Device Verification Request
* [complete](docs/sdks/deviceflow/README.md#complete) - Complete Device Authorization

### [dynamic_client_registration](docs/sdks/dynamicclientregistration/README.md)

* [register](docs/sdks/dynamicclientregistration/README.md#register) - Register Client
* [get](docs/sdks/dynamicclientregistration/README.md#get) - Get Client
* [update](docs/sdks/dynamicclientregistration/README.md#update) - Update Client
* [delete](docs/sdks/dynamicclientregistration/README.md#delete) - Delete Client

### [federation](docs/sdks/federation/README.md)

* [configuration](docs/sdks/federation/README.md#configuration) - Process Entity Configuration Request
* [registration](docs/sdks/federation/README.md#registration) - Process Federation Registration Request

### [grant_management](docs/sdks/grantmanagement/README.md)

* [process_request](docs/sdks/grantmanagement/README.md#process_request) - Process Grant Management Request

### [hardware_security_keys](docs/sdks/hardwaresecuritykeys/README.md)

* [create](docs/sdks/hardwaresecuritykeys/README.md#create) - Create Security Key
* [delete](docs/sdks/hardwaresecuritykeys/README.md#delete) - Delete Security Key
* [get](docs/sdks/hardwaresecuritykeys/README.md#get) - Get Security Key
* [list](docs/sdks/hardwaresecuritykeys/README.md#list) - List Security Keys

### [introspection](docs/sdks/introspection/README.md)

* [process](docs/sdks/introspection/README.md#process) - Process Introspection Request
* [standard_process](docs/sdks/introspection/README.md#standard_process) - Process OAuth 2.0 Introspection Request

### [jose_object](docs/sdks/joseobject/README.md)

* [jose_verify_api](docs/sdks/joseobject/README.md#jose_verify_api) - Verify JOSE

### [jwk_set_endpoint](docs/sdks/jwksetendpoint/README.md)

* [service_jwks_get_api](docs/sdks/jwksetendpoint/README.md#service_jwks_get_api) - Get JWK Set

### [native_sso](docs/sdks/nativesso/README.md)

* [process](docs/sdks/nativesso/README.md#process) - Native SSO Processing
* [logout](docs/sdks/nativesso/README.md#logout) - Native SSO Logout Processing

### [pushed_authorization](docs/sdks/pushedauthorization/README.md)

* [create](docs/sdks/pushedauthorization/README.md#create) - Process Pushed Authorization Request

### [revocation](docs/sdks/revocation/README.md)

* [process](docs/sdks/revocation/README.md#process) - Process Revocation Request

### [service](docs/sdks/service/README.md)

* [get](docs/sdks/service/README.md#get) - Get Service
* [list](docs/sdks/service/README.md#list) - List Services
* [create](docs/sdks/service/README.md#create) - Create Service
* [update](docs/sdks/service/README.md#update) - Update Service
* [delete](docs/sdks/service/README.md#delete) - Delete Service ⚡
* [get_configuration](docs/sdks/service/README.md#get_configuration) - Get Service Configuration

### [token](docs/sdks/token/README.md)

* [process](docs/sdks/token/README.md#process) - Process Token Request
* [fail](docs/sdks/token/README.md#fail) - Fail Token Request
* [issue](docs/sdks/token/README.md#issue) - Issue Token Response

#### [token.management](docs/sdks/tokenmanagement/README.md)

* [reissue_id_token](docs/sdks/tokenmanagement/README.md#reissue_id_token) - Reissue ID Token
* [list](docs/sdks/tokenmanagement/README.md#list) - List Issued Tokens
* [create](docs/sdks/tokenmanagement/README.md#create) - Create Access Token
* [update](docs/sdks/tokenmanagement/README.md#update) - Update Access Token
* [delete](docs/sdks/tokenmanagement/README.md#delete) - Delete Access Token
* [revoke](docs/sdks/tokenmanagement/README.md#revoke) - Revoke Access Token

### [userinfo](docs/sdks/userinfo/README.md)

* [process](docs/sdks/userinfo/README.md#process) - Process UserInfo Request
* [issue](docs/sdks/userinfo/README.md#issue) - Issue UserInfo Response

### [verifiable_credentials](docs/sdks/verifiablecredentials/README.md)

* [get_metadata](docs/sdks/verifiablecredentials/README.md#get_metadata) - Get Verifiable Credential Issuer Metadata
* [get_jwt_issuer](docs/sdks/verifiablecredentials/README.md#get_jwt_issuer) - Get JWT Issuer Information
* [get_jwks](docs/sdks/verifiablecredentials/README.md#get_jwks) - Get JSON Web Key Set
* [create_offer](docs/sdks/verifiablecredentials/README.md#create_offer) - Create Credential Offer
* [get_offer_info](docs/sdks/verifiablecredentials/README.md#get_offer_info) - Get Credential Offer Information
* [parse](docs/sdks/verifiablecredentials/README.md#parse) - Parse Single Credential
* [issue](docs/sdks/verifiablecredentials/README.md#issue) - Issue Single Credential
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

When custom error responses are specified for an operation, the SDK may also throw their associated exception. You can refer to respective *Errors* tables in SDK docs for more details on possible exception types for each operation. For example, the `get` method throws the following exceptions:

| Error Type                  | Status Code   | Content Type     |
| --------------------------- | ------------- | ---------------- |
| Models::Errors::ResultError | 400, 401, 403 | application/json |
| Models::Errors::ResultError | 500           | application/json |
| Errors::APIError            | 4XX, 5XX      | \*/\*            |

### Example

```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

begin
    res = s.service.get(service_id: '<id>')

    unless res.service.nil?
      # handle response
    end
rescue Models::Errors::ResultError => e
  # handle $e->$container data
  throw $e;
rescue Models::Errors::ResultError => e
  # handle $e->$container data
  throw $e;
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
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      server_idx: 3,
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.service.get(service_id: '<id>')

unless res.service.nil?
  # handle response
end

```

### Override Server URL Per-Client

The default server can also be overridden globally by passing a URL to the `server_url (String)` optional parameter when initializing the SDK client instance. For example:
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      server_url: 'https://br.authlete.com',
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.service.get(service_id: '<id>')

unless res.service.nil?
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

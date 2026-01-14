# Authlete Ruby SDK Examples

This directory contains example code demonstrating how to use the Authlete Ruby SDK.

## Examples

### Service Management

#### Get Service
**File:** `get_service.rb`

Retrieves a service by ID.

```bash
ruby examples/get_service.rb
```

#### Get Service Configuration
**File:** `get_service_configuration.rb`

Retrieves OpenID Connect Discovery configuration for a service.

```bash
ruby examples/get_service_configuration.rb
```

#### Create Service
**File:** `create_service.rb`

Creates a new service. Requires organization-level access token.

```bash
ruby examples/create_service.rb
```

### Client Management

#### Create Client
**File:** `create_client.rb`

Creates a new OAuth client.

```bash
ruby examples/create_client.rb
```

#### List Clients
**File:** `list_clients.rb`

Lists all OAuth clients for a service.

```bash
ruby examples/list_clients.rb
```

### OAuth 2.0 Flows

#### OAuth 2.0 Authorization Code Flow with PKCE
**File:** `oauth_flow.rb`

A complete end-to-end example of the OAuth 2.0 Authorization Code Flow with PKCE (Proof Key for Code Exchange).

**What it demonstrates:**
- ✅ Authorization request with PKCE
- ✅ Authorization code issuance
- ✅ Token exchange
- ✅ Token introspection

```bash
ruby examples/oauth_flow.rb
```

**Expected Output:**
```
=== OAuth 2.0 Authorization Code Flow ===
Service: 123456 | Client: 789012

[1/4] Authorization Request...
Action: INTERACTION
✓ Ticket: abc123...

[2/4] Issue Authorization Code...
Action: OK
✓ Code: xyz789...

[3/4] Token Request...
Action: OK
✓ Access Token: token123...

[4/4] Introspect Token...
Action: OK
✓ Token is valid

=== SUCCESS: OAuth flow completed ===
```

## Setup

1. Create a `.env` file in the `examples` directory:
   ```bash
   cp .env.example .env
   ```

2. Fill in your credentials in `.env`

## Environment Variables

All examples use environment variables for configuration:

**Required for all examples:**
- `API_URL` - Authlete API base URL (e.g., `https://us.authlete.com`)
- `ACCESS_TOKEN` - Your Authlete access token (service bearer token)

**Required for service/client examples:**
- `SERVICE_ID` - Your Authlete service ID

**Required for OAuth flow examples:**
- `CLIENT_ID` - OAuth client ID
- `CLIENT_SECRET` - OAuth client secret
- `REDIRECT_URI` - OAuth redirect URI
- `SCOPE` - OAuth scopes (default: `openid profile`)
- `SUBJECT` - User subject identifier (default: `testuser`)

**Required for service creation:**
- `ORG_TOKEN` - Organization-level access token (or use `ACCESS_TOKEN`)

## Error Handling

Examples demonstrate proper error handling:

```ruby
rescue Authlete::Models::Errors::ResultError => e
  puts "Authlete error: #{e.result_code} - #{e.result_message}"
rescue Authlete::Models::Errors::APIError => e
  puts "HTTP error: #{e.status_code}"
end
```

## Notes

- Examples use the `authlete_ruby_test` gem (beta version)
- For production, use the stable `authlete_ruby_sdk` gem (when available)
- All examples are executable Ruby scripts
- Examples include colored output for better readability

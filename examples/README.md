# Authlete Ruby SDK Examples

This directory contains example code demonstrating how to use the Authlete Ruby SDK.

## Example

### OAuth 2.0 Authorization Code Flow with PKCE

**File:** `oauth_flow.rb`

A complete end-to-end example of the OAuth 2.0 Authorization Code Flow with PKCE (Proof Key for Code Exchange).

**What it demonstrates:**
- ✅ Authorization request with PKCE
- ✅ Authorization code issuance
- ✅ Token exchange
- ✅ Token introspection

**Usage:**

1. Create a `.env` file in the `examples` directory:
   ```bash
   cp .env.example .env
   ```

2. Fill in your credentials in `.env`:
   ```env
   API_URL=https://us.authlete.com
   SERVICE_ID=your_service_id
   ACCESS_TOKEN=your_access_token
   CLIENT_ID=your_client_id
   CLIENT_SECRET=your_client_secret
   REDIRECT_URI=https://your-app.com/callback
   SCOPE=openid profile
   SUBJECT=testuser
   ```

3. Run the example:
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

## Basic Usage Pattern

Here's a recommended pattern for using the SDK with better object naming:

```ruby
require 'authlete_ruby_test'

# Create an alias for cleaner code
Models = ::Authlete::Models

# Initialize the Authlete client (following Stripe's pattern: stripe_client = Stripe::StripeClient.new)
authlete_client = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>',
  server_url: 'https://us.authlete.com'
)

# Example: Retrieve a service
response = authlete_client.services.retrieve(service_id: '<service_id>')

unless response.service.nil?
  service = response.service
  puts "Service Name: #{service.service_name}"
  puts "Service ID: #{service.api_key}"
end
```

**Benefits of this pattern:**
- `authlete_client` follows Stripe's naming convention (`stripe_client`) and avoids confusion with OAuth clients
- `Models` alias reduces verbosity when working with model classes
- `response` clearly indicates the API response object
- `service` clearly indicates the service data

## Environment Variables

**Required:**
- `API_URL` - Authlete API base URL (e.g., `https://us.authlete.com`)
- `SERVICE_ID` - Your Authlete service ID
- `ACCESS_TOKEN` - Your Authlete access token (service bearer token)
- `CLIENT_ID` - OAuth client ID
- `CLIENT_SECRET` - OAuth client secret
- `REDIRECT_URI` - OAuth redirect URI

**Optional:**
- `SCOPE` - OAuth scopes (default: `openid profile`)
- `SUBJECT` - User subject identifier (default: `testuser`)

## Error Handling

The example demonstrates proper error handling:

```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
authlete_client = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>',
  server_url: 'https://us.authlete.com'
)

begin
  response = authlete_client.services.retrieve(service_id: '<service_id>')
  # Handle success
rescue Models::Errors::ResultError => e
  puts "Authlete error: #{e.result_code} - #{e.result_message}"
rescue Models::Errors::APIError => e
  puts "HTTP error: #{e.status_code}"
end
```

## Notes

- Uses the `authlete_ruby_test` gem (beta version)
- Auto-installs the gem if not available
- Includes colored output for better readability
- Loads environment variables from `.env` file
- Recommended to use descriptive variable names (`authlete_client`, `response`, `service`) instead of short names (`s`, `res`, `svc`) to avoid confusion with OAuth client entities

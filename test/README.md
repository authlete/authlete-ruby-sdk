# Tests

These tests run against a live Authlete API server. They require a pre-existing service and a
service access token. Tests run sequentially and share a single service — each test creates and
deletes its own OAuth client, and updates the service settings it needs in `setup`/`teardown`.

## Prerequisites

1. An Authlete API server (cloud or self-hosted)
2. A service has been created in the Authlete console
3. A service access token has been generated for that service in the console
4. An org-level access token for managing service and client settings per test

```bash
bundle install
```

## Run all tests

```bash
API_BASE_URL="<authlete-api-server-url>" \
  SERVICE_ID="<service-id>" \
  SERVICE_TOKEN="<service-access-token>" \
  ORG_TOKEN="<org-access-token>" \
  bundle exec rake test
```

## Run a single file

```bash
API_BASE_URL="<authlete-api-server-url>" \
  SERVICE_ID="<service-id>" \
  SERVICE_TOKEN="<service-access-token>" \
  ORG_TOKEN="<org-access-token>" \
  bundle exec ruby -Itest test/auth_grant_test.rb
```

Add `-v` for verbose per-test output:

```bash
API_BASE_URL="<authlete-api-server-url>" \
  SERVICE_ID="<service-id>" \
  SERVICE_TOKEN="<service-access-token>" \
  ORG_TOKEN="<org-access-token>" \
  bundle exec ruby -Itest test/auth_grant_test.rb -v
```

## Environment variables

| Variable | Required | Description |
|---|---|---|
| `API_BASE_URL` | Yes | Authlete API server URL — e.g. `https://us.authlete.com` |
| `SERVICE_ID` | Yes | Numeric ID of the pre-existing service |
| `SERVICE_TOKEN` | Yes | Service access token — used for OAuth flow operations (authorization, token, introspection, revocation) |
| `ORG_TOKEN` | No | Org-level access token — used to manage service settings and clients for each test. Falls back to `SERVICE_TOKEN` if not set. |

> **Local dev only:** if running against a local environment using mkcert TLS,
> prepend `SSL_CERT_FILE="$(mkcert -CAROOT)/rootCA.pem"` to the command.

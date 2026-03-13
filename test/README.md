# Integration Tests

Requires a running local-dev environment (`authlete-dev`).

## Setup

```bash
bundle install
```

## Run

```bash
SSL_CERT_FILE="$(mkcert -CAROOT)/rootCA.pem" \
IDP_BASE_URL="https://login.authlete.local" \
API_BASE_URL="https://api.authlete.local" \
AUTHLETE_ORG_TOKEN="<org-token>" \
ORG_ID="<org-id>" \
API_SERVER_ID="<api-server-id>" \
bundle exec rake integration
```

Add `-v` for verbose per-test output:

```bash
bundle exec ruby -Ilib:test test/integration/auth_grant_flow_test.rb -v
```

## Environment Variables

| Variable | Description |
|---|---|
| `SSL_CERT_FILE` | Path to mkcert root CA (`$(mkcert -CAROOT)/rootCA.pem`) |
| `IDP_BASE_URL` | IDP base URL (e.g. `https://login.authlete.local`) |
| `API_BASE_URL` | Authlete API server URL (e.g. `https://api.authlete.local`) |
| `AUTHLETE_ORG_TOKEN` | Organization bearer token |
| `ORG_ID` | Organization ID |
| `API_SERVER_ID` | API server ID |

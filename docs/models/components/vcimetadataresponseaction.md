# VciMetadataResponseAction

The next action that the implementation of the credential issuer
metadata endpoint (`/.well-known/openid-credential-issuer`)
should take after getting a response from Authlete's
`/vci/metadata` API.


## Example Usage

```ruby
require "authlete_ruby_sdk"

value = VciMetadataResponseAction::OK
```


## Values

| Name                    | Value                   |
| ----------------------- | ----------------------- |
| `OK`                    | OK                      |
| `NOT_FOUND`             | NOT_FOUND               |
| `INTERNAL_SERVER_ERROR` | INTERNAL_SERVER_ERROR   |
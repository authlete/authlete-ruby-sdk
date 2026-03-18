# VciJwtissuerResponseAction

The next action that the implementation of the JWT issuer metadata
endpoint (`/.well-known/jwt-issuer`) should take after getting
a response from Authlete's `/vci/jwtissuer` API.


## Example Usage

```ruby
require "authlete_ruby_sdk"

value = VciJwtissuerResponseAction::OK
```


## Values

| Name                    | Value                   |
| ----------------------- | ----------------------- |
| `OK`                    | OK                      |
| `NOT_FOUND`             | NOT_FOUND               |
| `INTERNAL_SERVER_ERROR` | INTERNAL_SERVER_ERROR   |
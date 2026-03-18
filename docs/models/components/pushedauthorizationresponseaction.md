# PushedAuthorizationResponseAction

The next action that the authorization server implementation should take. Any other value other than "CREATED" should be handled as unsuccessful result.

## Example Usage

```ruby
require "authlete_ruby_sdk"

value = PushedAuthorizationResponseAction::CREATED
```


## Values

| Name                    | Value                   |
| ----------------------- | ----------------------- |
| `CREATED`               | CREATED                 |
| `BAD_REQUEST`           | BAD_REQUEST             |
| `UNAUTHORIZED`          | UNAUTHORIZED            |
| `FORBIDDEN`             | FORBIDDEN               |
| `PAYLOAD_TOO_LARGE`     | PAYLOAD_TOO_LARGE       |
| `INTERNAL_SERVER_ERROR` | INTERNAL_SERVER_ERROR   |
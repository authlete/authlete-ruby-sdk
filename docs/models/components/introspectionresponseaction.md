# IntrospectionResponseAction

The next action that the authorization server implementation should take.

## Example Usage

```ruby
require "authlete_ruby_sdk"

value = IntrospectionResponseAction::INTERNAL_SERVER_ERROR
```


## Values

| Name                    | Value                   |
| ----------------------- | ----------------------- |
| `INTERNAL_SERVER_ERROR` | INTERNAL_SERVER_ERROR   |
| `BAD_REQUEST`           | BAD_REQUEST             |
| `UNAUTHORIZED`          | UNAUTHORIZED            |
| `FORBIDDEN`             | FORBIDDEN               |
| `OK`                    | OK                      |
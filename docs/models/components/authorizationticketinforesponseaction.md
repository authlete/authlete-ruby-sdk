# AuthorizationTicketInfoResponseAction

The result of the `/auth/authorization/ticket/info` API call.

## Example Usage

```ruby
require "authlete_ruby_sdk"

value = AuthorizationTicketInfoResponseAction::OK
```


## Values

| Name             | Value            |
| ---------------- | ---------------- |
| `OK`             | OK               |
| `NOT_FOUND`      | NOT_FOUND        |
| `CALLER_ERROR`   | CALLER_ERROR     |
| `AUTHLETE_ERROR` | AUTHLETE_ERROR   |
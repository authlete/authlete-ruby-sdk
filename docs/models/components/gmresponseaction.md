# GMResponseAction

The next action that the authorization server implementation should take.

## Example Usage

```ruby
require "authlete_ruby_sdk"

value = GMResponseAction::OK
```


## Values

| Name             | Value            |
| ---------------- | ---------------- |
| `OK`             | OK               |
| `NO_CONTENT`     | NO_CONTENT       |
| `UNAUTHORIZED`   | UNAUTHORIZED     |
| `FORBIDDEN`      | FORBIDDEN        |
| `NOT_FOUND`      | NOT_FOUND        |
| `CALLER_ERROR`   | CALLER_ERROR     |
| `AUTHLETE_ERROR` | AUTHLETE_ERROR   |
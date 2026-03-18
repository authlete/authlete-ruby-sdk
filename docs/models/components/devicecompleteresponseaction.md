# DeviceCompleteResponseAction

The next action that the authorization server implementation should take.


## Example Usage

```ruby
require "authlete_ruby_sdk"

value = DeviceCompleteResponseAction::SERVER_ERROR
```


## Values

| Name                  | Value                 |
| --------------------- | --------------------- |
| `SERVER_ERROR`        | SERVER_ERROR          |
| `USER_CODE_NOT_EXIST` | USER_CODE_NOT_EXIST   |
| `USER_CODE_EXPIRED`   | USER_CODE_EXPIRED     |
| `INVALID_REQUEST`     | INVALID_REQUEST       |
| `SUCCESS`             | SUCCESS               |
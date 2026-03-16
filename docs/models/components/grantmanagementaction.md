# GrantManagementAction

The grant management action of the device authorization request.

The `grant_management_action` request parameter is defined in
[Grant Management for OAuth 2.0](https://openid.net/specs/fapi-grant-management.html).


## Example Usage

```ruby
require "authlete_ruby_sdk"

value = GrantManagementAction::CREATE
```


## Values

| Name      | Value     |
| --------- | --------- |
| `CREATE`  | CREATE    |
| `QUERY`   | QUERY     |
| `REPLACE` | REPLACE   |
| `REVOKE`  | REVOKE    |
| `MERGE`   | MERGE     |
# BackchannelAuthenticationFailRequestReason

The reason of the failure of the backchannel authentication request. This request parameter is
not mandatory but optional. However, giving this parameter is recommended. If omitted, `SERVER_ERROR`
is used as a reason.



## Values

| Name                       | Value                      |
| -------------------------- | -------------------------- |
| `ACCESS_DENIED`            | ACCESS_DENIED              |
| `EXPIRED_LOGIN_HINT_TOKEN` | EXPIRED_LOGIN_HINT_TOKEN   |
| `INVALID_BINDING_MESSAGE`  | INVALID_BINDING_MESSAGE    |
| `INVALID_TARGET`           | INVALID_TARGET             |
| `INVALID_USER_CODE`        | INVALID_USER_CODE          |
| `MISSING_USER_CODE`        | MISSING_USER_CODE          |
| `SERVER_ERROR`             | SERVER_ERROR               |
| `UNAUTHORIZED_CLIENT`      | UNAUTHORIZED_CLIENT        |
| `UNKNOWN_USER_ID`          | UNKNOWN_USER_ID            |
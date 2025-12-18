# AuthorizationFailRequestReason

The reason of the failure of the authorization request.
For more details, see [NO_INTERACTION] in the description of `/auth/authorization` API.



## Values

| Name                         | Value                        |
| ---------------------------- | ---------------------------- |
| `UNKNOWN`                    | UNKNOWN                      |
| `NOT_LOGGED_IN`              | NOT_LOGGED_IN                |
| `MAX_AGE_NOT_SUPPORTED`      | MAX_AGE_NOT_SUPPORTED        |
| `EXCEEDS_MAX_AGE`            | EXCEEDS_MAX_AGE              |
| `DIFFERENT_SUBJECT`          | DIFFERENT_SUBJECT            |
| `ACR_NOT_SATISFIED`          | ACR_NOT_SATISFIED            |
| `DENIED`                     | DENIED                       |
| `SERVER_ERROR`               | SERVER_ERROR                 |
| `NOT_AUTHENTICATED`          | NOT_AUTHENTICATED            |
| `ACCOUNT_SELECTION_REQUIRED` | ACCOUNT_SELECTION_REQUIRED   |
| `CONSENT_REQUIRED`           | CONSENT_REQUIRED             |
| `INTERACTION_REQUIRED`       | INTERACTION_REQUIRED         |
| `INVALID_TARGET`             | INVALID_TARGET               |
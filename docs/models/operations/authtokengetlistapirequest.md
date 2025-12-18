# AuthTokenGetListApiRequest


## Fields

| Field                                                              | Type                                                               | Required                                                           | Description                                                        |
| ------------------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------------------------------------ |
| `service_id`                                                       | *::String*                                                         | :heavy_check_mark:                                                 | A service ID.                                                      |
| `client_identifier`                                                | *T.nilable(::String)*                                              | :heavy_minus_sign:                                                 | Client Identifier (client ID or client ID alias).<br/>             |
| `subject`                                                          | *T.nilable(::String)*                                              | :heavy_minus_sign:                                                 | Unique user ID.<br/>                                               |
| `start`                                                            | *T.nilable(::Integer)*                                             | :heavy_minus_sign:                                                 | Start index of search results (inclusive). The default value is 0. |
| `end_`                                                             | *T.nilable(::Integer)*                                             | :heavy_minus_sign:                                                 | End index of search results (exclusive). The default value is 5.<br/> |
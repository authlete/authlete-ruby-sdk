# ClientAuthorizationGetListApiRequest


## Fields

| Field                                                              | Type                                                               | Required                                                           | Description                                                        |
| ------------------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------------------------------------ | ------------------------------------------------------------------ |
| `service_id`                                                       | *::String*                                                         | :heavy_check_mark:                                                 | A service ID.                                                      |
| `subject_path_parameter`                                           | *::String*                                                         | :heavy_check_mark:                                                 | Unique user ID of an end-user.<br/>                                |
| `subject_query_parameter`                                          | *::String*                                                         | :heavy_check_mark:                                                 | Unique user ID of an end-user.<br/>                                |
| `developer`                                                        | *T.nilable(::String)*                                              | :heavy_minus_sign:                                                 | Unique ID of a client developer.<br/>                              |
| `start`                                                            | *T.nilable(::Integer)*                                             | :heavy_minus_sign:                                                 | Start index of search results (inclusive). The default value is 0. |
| `end_`                                                             | *T.nilable(::Integer)*                                             | :heavy_minus_sign:                                                 | End index of search results (exclusive). The default value is 5.<br/> |
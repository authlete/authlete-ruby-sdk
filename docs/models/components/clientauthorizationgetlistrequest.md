# ClientAuthorizationGetListRequest


## Fields

| Field                                      | Type                                       | Required                                   | Description                                |
| ------------------------------------------ | ------------------------------------------ | ------------------------------------------ | ------------------------------------------ |
| `subject`                                  | *::String*                                 | :heavy_check_mark:                         | Unique user ID of an end-user.             |
| `developer`                                | *T.nilable(::String)*                      | :heavy_minus_sign:                         | Unique ID of a client developer.           |
| `start`                                    | *T.nilable(::Integer)*                     | :heavy_minus_sign:                         | Start index of search results (inclusive). |
| `end_`                                     | *T.nilable(::Integer)*                     | :heavy_minus_sign:                         | End index of search results (exclusive).   |
# JoseVerifyResponse


## Fields

| Field                                                      | Type                                                       | Required                                                   | Description                                                |
| ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------------- |
| `result_code`                                              | *T.nilable(::String)*                                      | :heavy_minus_sign:                                         | The code which represents the result of the API call.      |
| `result_message`                                           | *T.nilable(::String)*                                      | :heavy_minus_sign:                                         | A short message which explains the result of the API call. |
| `valid`                                                    | *T.nilable(T::Boolean)*                                    | :heavy_minus_sign:                                         | The result of the verification on the JOSE object.<br/>    |
| `signature_valid`                                          | *T.nilable(T::Boolean)*                                    | :heavy_minus_sign:                                         | The result of the signature verification.<br/>             |
| `missing_claims`                                           | T::Array<*::String*>                                       | :heavy_minus_sign:                                         | The list of missing claims.<br/>                           |
| `invalid_claims`                                           | T::Array<*::String*>                                       | :heavy_minus_sign:                                         | The list of invalid claims.<br/>                           |
| `error_descriptions`                                       | T::Array<*::String*>                                       | :heavy_minus_sign:                                         | The list of error messages.<br/>                           |
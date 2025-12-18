# CredentialRequestInfo


## Fields

| Field                                                               | Type                                                                | Required                                                            | Description                                                         |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `identifier`                                                        | *T.nilable(::String)*                                               | :heavy_minus_sign:                                                  | The identifier of the credential offer.                             |
| `format`                                                            | *T.nilable(::String)*                                               | :heavy_minus_sign:                                                  | The value of the format parameter in the credential request.        |
| `binding_key`                                                       | *T.nilable(::String)*                                               | :heavy_minus_sign:                                                  | The binding key specified by the proof in the credential request.   |
| `binding_keys`                                                      | T::Array<*::String*>                                                | :heavy_minus_sign:                                                  | The binding keys specified by the proofs in the credential request. |
| `details`                                                           | *T.nilable(::String)*                                               | :heavy_minus_sign:                                                  | The details about the credential request.                           |
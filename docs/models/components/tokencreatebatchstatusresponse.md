# TokenCreateBatchStatusResponse

Response from a token create batch status request.



## Fields

| Field                                                                                      | Type                                                                                       | Required                                                                                   | Description                                                                                |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| `result_code`                                                                              | *T.nilable(::String)*                                                                      | :heavy_minus_sign:                                                                         | The result code of the request.                                                            |
| `result_message`                                                                           | *T.nilable(::String)*                                                                      | :heavy_minus_sign:                                                                         | The result message of the request.                                                         |
| `status`                                                                                   | [T.nilable(Models::Components::TokenBatchStatus)](../../models/shared/tokenbatchstatus.md) | :heavy_minus_sign:                                                                         | Status of a token batch operation.<br/>                                                    |
# ResultError


## Fields

| Field                                                                       | Type                                                                        | Required                                                                    | Description                                                                 |
| --------------------------------------------------------------------------- | --------------------------------------------------------------------------- | --------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| `result_code`                                                               | *T.nilable(::String)*                                                       | :heavy_minus_sign:                                                          | The code which represents the result of the API call.                       |
| `result_message`                                                            | *T.nilable(::String)*                                                       | :heavy_minus_sign:                                                          | A short message which explains the result of the API call.                  |
| `raw_response`                                                              | [Faraday::Response](https://www.rubydoc.info/gems/faraday/Faraday/Response) | :heavy_minus_sign:                                                          | Raw HTTP response; suitable for custom response parsing                     |
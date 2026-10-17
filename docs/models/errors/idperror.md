# IdpError

Error response returned by the Authlete IdP server. Unlike the main API's
`resultCode`/`resultMessage` format, IdP errors carry a human-readable `error` message,
optionally accompanied by contextual fields (such as `organizationId` or `apiServerId`).
Request validation failures instead return an `errors` array of per-field messages.



## Fields

| Field                                                                         | Type                                                                          | Required                                                                      | Description                                                                   |
| ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `error`                                                                       | *T.nilable(::String)*                                                         | :heavy_minus_sign:                                                            | A human-readable error message.                                               |
| `errors`                                                                      | T::Array<*::String*>                                                          | :heavy_minus_sign:                                                            | Per-field validation error messages, present for request validation failures. |
| `additional_properties`                                                       | T::Hash[Symbol, *::Object*]                                                   | :heavy_minus_sign:                                                            | N/A                                                                           |
| `raw_response`                                                                | [Faraday::Response](https://www.rubydoc.info/gems/faraday/Faraday/Response)   | :heavy_minus_sign:                                                            | Raw HTTP response; suitable for custom response parsing                       |
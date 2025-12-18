# TokenFailRequest


## Fields

| Field                                                                                       | Type                                                                                        | Required                                                                                    | Description                                                                                 |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `ticket`                                                                                    | *::String*                                                                                  | :heavy_check_mark:                                                                          | The ticket issued from Authlete `/auth/token` API.<br/>                                     |
| `reason`                                                                                    | [Models::Components::TokenFailRequestReason](../../models/shared/tokenfailrequestreason.md) | :heavy_check_mark:                                                                          | The reason of the failure of the token request.<br/>                                        |
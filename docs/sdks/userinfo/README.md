# Userinfo

## Overview

### Available Operations

* [process_request](#process_request) - Process UserInfo Request
* [issue_response](#issue_response) - Issue UserInfo Response

## process_request

This API gathers information about a user.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_userinfo_api" method="post" path="/api/{serviceId}/auth/userinfo" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.userinfo.process_request(service_id: '<id>', userinfo_request: Models::Components::UserinfoRequest.new(
  token: 'Ntm9MDb8WXQAevqrBkd84KTTHbYHVQrTjgUZCOWqEUI'
))

unless res.userinfo_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                     | Type                                                                          | Required                                                                      | Description                                                                   |
| ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `service_id`                                                                  | *::String*                                                                    | :heavy_check_mark:                                                            | A service ID.                                                                 |
| `userinfo_request`                                                            | [Models::Components::UserinfoRequest](../../models/shared/userinforequest.md) | :heavy_check_mark:                                                            | N/A                                                                           |

### Response

**[T.nilable(Models::Operations::AuthUserinfoApiResponse)](../../models/operations/authuserinfoapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |

## issue_response

This API generates an ID token.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="auth_userinfo_issue_api" method="post" path="/api/{serviceId}/auth/userinfo/issue" -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.userinfo.issue_response(service_id: '<id>', userinfo_issue_request: Models::Components::UserinfoIssueRequest.new(
  token: 'Ntm9MDb8WXQAevqrBkd84KTTHbYHVQrTjgUZCOWqEUI'
))

unless res.userinfo_issue_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                               | Type                                                                                    | Required                                                                                | Description                                                                             |
| --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| `service_id`                                                                            | *::String*                                                                              | :heavy_check_mark:                                                                      | A service ID.                                                                           |
| `userinfo_issue_request`                                                                | [Models::Components::UserinfoIssueRequest](../../models/shared/userinfoissuerequest.md) | :heavy_check_mark:                                                                      | N/A                                                                                     |

### Response

**[T.nilable(Models::Operations::AuthUserinfoIssueApiResponse)](../../models/operations/authuserinfoissueapiresponse.md)**

### Errors

| Error Type                  | Status Code                 | Content Type                |
| --------------------------- | --------------------------- | --------------------------- |
| Models::Errors::ResultError | 400, 401, 403               | application/json            |
| Models::Errors::ResultError | 500                         | application/json            |
| Errors::APIError            | 4XX, 5XX                    | \*/\*                       |
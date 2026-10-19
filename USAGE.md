<!-- Start SDK Example Usage [usage] -->
```ruby
require 'authlete_ruby_sdk'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
  service_id: '<id>',
  bearer: '<YOUR_BEARER_TOKEN_HERE>'
)
res = s.services.retrieve

unless res.service.nil?
  # handle response
end

```
<!-- End SDK Example Usage [usage] -->
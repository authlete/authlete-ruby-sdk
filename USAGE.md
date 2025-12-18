<!-- Start SDK Example Usage [usage] -->
```ruby
require 'authlete_ruby_test'

Models = ::Authlete::Models
s = ::Authlete::Client.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.services.retrieve(service_id: '<id>')

unless res.service.nil?
  # handle response
end

```
<!-- End SDK Example Usage [usage] -->
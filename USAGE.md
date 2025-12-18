<!-- Start SDK Example Usage [usage] -->
```ruby
require 'authlete'

Models = ::Authlete::Models
s = ::Authlete::Authlete.new(
      bearer: '<YOUR_BEARER_TOKEN_HERE>',
    )

res = s.service.get(service_id: '<id>')

unless res.service.nil?
  # handle response
end

```
<!-- End SDK Example Usage [usage] -->
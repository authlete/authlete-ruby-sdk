#!/usr/bin/env ruby
# frozen_string_literal: true

# Example: Create Service
# 
# This example demonstrates how to create a new service using the Authlete Ruby SDK.
# Note: This requires an organization-level access token.
#
# Usage:
#   ruby examples/create_service.rb

# Auto-install gem if not available
begin
  require 'authlete_ruby_test'
rescue LoadError
  puts "\033[33mInstalling authlete_ruby_test gem...\033[0m"
  system('gem', 'install', 'authlete_ruby_test', '--pre') || abort("\033[31mFailed to install gem\033[0m")
  require 'authlete_ruby_test'
end

# Load .env file
env_file = File.join(__dir__, '.env')
if File.exist?(env_file)
  File.readlines(env_file).each do |line|
    next if line.strip.empty? || line.start_with?('#')
    key, value = line.strip.split('=', 2)
    ENV[key] = value if key && value
  end
end

# Configuration
API_URL = ENV['API_URL'] || 'https://us.authlete.com'
ORG_TOKEN = ENV['ORG_TOKEN'] || ENV['ACCESS_TOKEN'] || abort("ERROR: ORG_TOKEN or ACCESS_TOKEN not set")

# Initialize client with org token
client = Authlete::Client.new(
  bearer: ORG_TOKEN,
  server_url: API_URL
)

begin
  puts "\033[36m=== Create Service ===\033[0m\n"
  
  # Create service input
  service_input = Authlete::Models::Components::ServiceInput.new(
    service_name: "Example Service #{Time.now.to_i}",
    issuer: "https://example.com",
    supported_grant_types: ["AUTHORIZATION_CODE", "CLIENT_CREDENTIALS", "REFRESH_TOKEN"],
    supported_response_types: ["CODE"],
    supported_scopes: [
      { name: "openid", description: "OpenID Connect" },
      { name: "profile", description: "User profile" }
    ]
  )
  
  # Create service
  result = client.services.create(request: service_input)
  
  if result.service
    service = result.service
    puts "\033[32m✓ Service created successfully\033[0m\n"
    puts "Service Name: #{service.service_name}"
    puts "Service ID: #{service.api_key}"
    puts "Issuer: #{service.issuer}"
    puts "Created At: #{service.created_at}" if service.respond_to?(:created_at)
  else
    puts "\033[31m✗ No service data returned\033[0m"
  end
  
rescue Authlete::Models::Errors::ResultError => e
  puts "\033[31mERROR: #{e.result_code} - #{e.result_message}\033[0m"
  exit 1
rescue Authlete::Models::Errors::APIError => e
  puts "\033[31mERROR: HTTP #{e.status_code}\033[0m"
  puts e.body if e.body && !e.body.empty?
  exit 1
end

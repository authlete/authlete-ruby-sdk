#!/usr/bin/env ruby
# frozen_string_literal: true

# Example: Get Service Configuration
# 
# This example demonstrates how to retrieve OpenID Connect Discovery configuration
# for a service using the Authlete Ruby SDK.
#
# Usage:
#   ruby examples/get_service_configuration.rb

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
SERVICE_ID = ENV['SERVICE_ID'] || abort("ERROR: SERVICE_ID not set")
ACCESS_TOKEN = ENV['ACCESS_TOKEN'] || abort("ERROR: ACCESS_TOKEN not set")

# Initialize client
client = Authlete::Client.new(
  bearer: ACCESS_TOKEN,
  server_url: API_URL
)

begin
  puts "\033[36m=== Get Service Configuration ===\033[0m"
  puts "Service ID: #{SERVICE_ID}\n"
  puts "Testing service.configuration endpoint...\n"
  puts "─" * 60
  
  # Get service configuration
  config = client.services.configuration(service_id: SERVICE_ID, pretty: true)
  
  puts "\033[32m✓ API Call Successful!\033[0m"
  puts "─" * 60
  
  # Access the configuration object
  config_obj = config.service_configuration_get_response if config.respond_to?(:service_configuration_get_response)
  config_obj ||= config.object if config.respond_to?(:object)
  config_obj ||= config
  
  if config_obj
    puts "Response Type: #{config_obj.class}"
    
    # Try to access properties
    if config_obj.respond_to?(:issuer)
      puts "\n✅ Configuration data received!"
      puts "Issuer: #{config_obj.issuer}"
      puts "Authorization Endpoint: #{config_obj.authorization_endpoint}" if config_obj.respond_to?(:authorization_endpoint)
      puts "Token Endpoint: #{config_obj.token_endpoint}" if config_obj.respond_to?(:token_endpoint)
      puts "UserInfo Endpoint: #{config_obj.userinfo_endpoint}" if config_obj.respond_to?(:userinfo_endpoint)
      puts "JWKS URI: #{config_obj.jwks_uri}" if config_obj.respond_to?(:jwks_uri)
    elsif config_obj.is_a?(Hash)
      puts "\n✅ Configuration data received!"
      puts "Keys: #{config_obj.keys.length}"
      puts "First 5 keys: #{config_obj.keys.first(5).join(', ')}"
      puts "\nSample values:"
      puts "  issuer: #{config_obj['issuer']}" if config_obj['issuer']
      puts "  authorization_endpoint: #{config_obj['authorization_endpoint']}" if config_obj['authorization_endpoint']
      puts "  token_endpoint: #{config_obj['token_endpoint']}" if config_obj['token_endpoint']
    else
      puts "\nResponse received: #{config_obj.inspect[0..200]}"
    end
  else
    puts "\n❌ Empty configuration"
  end
  
rescue Authlete::Models::Errors::ResultError => e
  puts "\033[31mERROR: #{e.result_code} - #{e.result_message}\033[0m"
  exit 1
rescue Authlete::Models::Errors::APIError => e
  puts "\033[31mERROR: HTTP #{e.status_code}\033[0m"
  puts e.body if e.body && !e.body.empty?
  exit 1
rescue => e
  puts "\033[31mERROR: #{e.class} - #{e.message}\033[0m"
  puts e.backtrace.first(5) if e.respond_to?(:backtrace)
  exit 1
end

#!/usr/bin/env ruby
# frozen_string_literal: true

# Example: Get Service
# 
# This example demonstrates how to retrieve a service using the Authlete Ruby SDK.
#
# Usage:
#   ruby examples/get_service.rb

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
  puts "\033[36m=== Get Service ===\033[0m"
  puts "Service ID: #{SERVICE_ID}\n"
  
  # Get service
  result = client.services.retrieve(service_id: SERVICE_ID)
  
  if result.service
    service = result.service
    puts "\033[32m✓ Service retrieved successfully\033[0m\n"
    puts "Service Name: #{service.service_name}"
    puts "Service ID: #{service.api_key}"
    puts "Issuer: #{service.issuer}"
    puts "Access Token Duration: #{service.access_token_duration}" if service.respond_to?(:access_token_duration)
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

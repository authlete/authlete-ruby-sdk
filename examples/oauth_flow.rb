#!/usr/bin/env ruby
# frozen_string_literal: true

# OAuth 2.0 Authorization Code Flow with PKCE Example
# 
# This example demonstrates a complete OAuth 2.0 Authorization Code Flow with PKCE
# using the Authlete Ruby SDK.
#
# Usage:
#   1. Copy env.example to .env
#   2. Fill in your credentials
#   3. Run: ruby examples/oauth_flow.rb

require 'uri'

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
API_URL = ENV['API_URL'] || abort("ERROR: API_URL not set")
SERVICE_ID = ENV['SERVICE_ID'] || abort("ERROR: SERVICE_ID not set")
ACCESS_TOKEN = ENV['ACCESS_TOKEN'] || abort("ERROR: ACCESS_TOKEN not set")
CLIENT_ID = ENV['CLIENT_ID'] || abort("ERROR: CLIENT_ID not set")
CLIENT_SECRET = ENV['CLIENT_SECRET'] || abort("ERROR: CLIENT_SECRET not set")
REDIRECT_URI = ENV['REDIRECT_URI'] || abort("ERROR: REDIRECT_URI not set")
SCOPE = ENV['SCOPE'] || 'openid profile'
SUBJECT = ENV['SUBJECT'] || 'testuser'

# PKCE values (static for testing)
CODE_CHALLENGE = 'E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM'
CODE_VERIFIER = 'dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk'

# Initialize client
client = Authlete::Client.new(bearer: ACCESS_TOKEN, server_url: API_URL)

puts "\033[36m=== OAuth 2.0 Authorization Code Flow ===\033[0m"
puts "Service: #{SERVICE_ID} | Client: #{CLIENT_ID}"

begin
  # Step 1: Authorization Request
  puts "\n\033[34m[1/4] Authorization Request...\033[0m"
  encoded_redirect_uri = URI.encode_www_form_component(REDIRECT_URI)
  parameters = "response_type=code&client_id=#{CLIENT_ID}&redirect_uri=#{encoded_redirect_uri}" \
               "&scope=#{SCOPE.gsub(' ', '+')}&code_challenge=#{CODE_CHALLENGE}&code_challenge_method=S256"
  
  auth_request = Authlete::Models::Components::AuthorizationRequest.new(parameters: parameters)
  response = client.authorization.process_request(service_id: SERVICE_ID, authorization_request: auth_request)
  
  auth_resp = response.authorization_response
  puts "Action: #{auth_resp.action}"
  puts "Result: #{auth_resp.result_code} - #{auth_resp.result_message}" if auth_resp.result_message
  
  ticket = auth_resp.ticket
  abort("\033[31mERROR: No ticket received (action was #{auth_resp.action})\033[0m") if ticket.nil? || ticket.empty?
  puts "\033[32m✓ Ticket: #{ticket}\033[0m"

  # Step 2: Issue Authorization Code
  puts "\n\033[34m[2/4] Issue Authorization Code...\033[0m"
  issue_request = Authlete::Models::Components::AuthorizationIssueRequest.new(ticket: ticket, subject: SUBJECT)
  response = client.authorization.issue_response(service_id: SERVICE_ID, authorization_issue_request: issue_request)
  
  issue_resp = response.authorization_issue_response
  puts "Action: #{issue_resp.action}"
  puts "Result: #{issue_resp.result_code} - #{issue_resp.result_message}" if issue_resp.result_message
  
  auth_code = issue_resp.authorization_code
  abort("\033[31mERROR: No authorization code received (action was #{issue_resp.action})\033[0m") if auth_code.nil? || auth_code.empty?
  puts "\033[32m✓ Code: #{auth_code}\033[0m"

  sleep 1

  # Step 3: Token Request
  puts "\n\033[34m[3/4] Token Request...\033[0m"
  parameters = "grant_type=authorization_code&code=#{auth_code}&redirect_uri=#{encoded_redirect_uri}" \
               "&code_verifier=#{CODE_VERIFIER}"
  
  token_request = Authlete::Models::Components::TokenRequest.new(
    parameters: parameters,
    client_id: CLIENT_ID,
    client_secret: CLIENT_SECRET
  )
  response = client.tokens.process_request(service_id: SERVICE_ID, token_request: token_request)
  
  token_resp = response.token_response
  puts "Action: #{token_resp.action}"
  puts "Result: #{token_resp.result_code} - #{token_resp.result_message}" if token_resp.result_message
  
  access_token = token_resp.access_token
  abort("\033[31mERROR: No access token received (action was #{token_resp.action})\033[0m") if access_token.nil? || access_token.empty?
  puts "\033[32m✓ Access Token: #{access_token}\033[0m"

  # Step 4: Introspection
  puts "\n\033[34m[4/4] Introspect Token...\033[0m"
  introspection_request = Authlete::Models::Components::IntrospectionRequest.new(token: access_token)
  response = client.introspection.process_request(service_id: SERVICE_ID, introspection_request: introspection_request)
  
  intro_resp = response.introspection_response
  puts "Action: #{intro_resp.action}"
  puts "Result: #{intro_resp.result_code} - #{intro_resp.result_message}" if intro_resp.result_message
  puts "\033[32m✓ Token is valid\033[0m"

  puts "\n\033[32m=== SUCCESS: OAuth flow completed ===\033[0m"

rescue Authlete::Models::Errors::ResultError => e
  puts "\n\033[31mERROR: #{e.result_code} - #{e.result_message}\033[0m"
  exit 1
rescue Authlete::Models::Errors::APIError => e
  puts "\n\033[31mERROR: HTTP #{e.status_code}\033[0m"
  puts e.body if e.body && !e.body.empty?
  exit 1
end

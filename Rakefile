# typed: true
# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'minitest/test_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

Minitest::TestTask.create do |t|
  # workaround to avoid throwing warnings from Janeway library circular require...
  t.warning = false
  t.test_globs = ['test/**/*_test.rb']
end

task :default => :test

# Run all tests:
#
# $ API_BASE_URL="https://api.authlete.local" \
#   SERVICE_ID="<service-id>" \
#   SERVICE_TOKEN="<service-access-token>" \
#   rake test
#
# Local dev only — prepend SSL_CERT_FILE="$(mkcert -CAROOT)/rootCA.pem"
#
# Run a single file:
#
# $ bundle exec ruby -Itest test/auth_grant_test.rb

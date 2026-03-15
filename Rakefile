# typed: true
# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'minitest/test_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

Minitest::TestTask.create do |t|
  # workaround to avoid throwing warnings from Janeway library circular require...
  t.warning = false
end

task :default => :test

Minitest::TestTask.create(:integration) do |t|
  t.warning = false
  t.test_globs = ['test/**/*_test.rb']
end

# Developers can run all tests with:
#
# $ rake test
#
# Developers can run individual test files with:
#
# $ rake test test/parameter_test
#
# and run individual tests by adding `focus` to the line before the test definition.
#
# Run integration tests (requires running local-dev environment):
#
# $ SSL_CERT_FILE="$(mkcert -CAROOT)/rootCA.pem" \
#   IDP_BASE_URL="https://idp.authlete.local" \
#   API_BASE_URL="https://api.authlete.local" \
#   AUTHLETE_ORG_TOKEN="<org-token>" \
#   ORG_ID="1" API_SERVER_ID="1" \
#   rake integration
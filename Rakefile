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
# $ API_BASE_URL="<authlete-api-server-url>" \
#   SERVICE_ID="<service-id>" \
#   SERVICE_TOKEN="<service-access-token>" \
#   ORG_TOKEN="<org-access-token>" \
#   bundle exec rake test
#
# Run a single file:
#
# $ API_BASE_URL="<authlete-api-server-url>" \
#   SERVICE_ID="<service-id>" \
#   SERVICE_TOKEN="<service-access-token>" \
#   ORG_TOKEN="<org-access-token>" \
#   bundle exec ruby -Itest test/auth_grant_test.rb

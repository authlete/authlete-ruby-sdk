# typed: true
# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'minitest/test_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new do |task|
  task.options = ['--parallel']
end

Minitest::TestTask.create do |t|
  # workaround to avoid throwing warnings from Janeway library circular require...
  t.warning = false
  t.test_globs = ['test/**/*_test.rb']
end

namespace :sorbet do
  desc "Remove legacy Sorbet artifacts like extra.rbi"
  task :clean do
    extra = File.join(__dir__, "extra.rbi")

    if File.exist?(extra)
      puts "Removing legacy file: extra.rbi"
      File.delete(extra)
    else
      puts "extra.rbi not present — nothing to clean"
    end
  end
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

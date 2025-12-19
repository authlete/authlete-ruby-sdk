# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = 'authlete_ruby_test'
  s.version     = '0.0.2-beta.1'
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['Apache-2.0']
  s.summary     = ''
  s.homepage    = 'https://github.com/authlete/authlete-ruby-sdk.git'
  s.description = 'Official Ruby SDK for Authlete API v3+'
  s.authors     = ['Authlete, Inc.']
  s.metadata    = {
    'homepage_uri' => 'https://github.com/authlete/authlete-ruby-sdk.git',
    'documentation_uri' => 'https://github.com/authlete/authlete-ruby-sdk.git',
    'source_code_uri' => 'https://github.com/authlete/authlete-ruby-sdk.git'
  }

  s.files         = Dir['{lib,test}/**/*']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 3.2'

  s.add_dependency('base64', '>= 0.2.0', '< 1.0')
  s.add_dependency('faraday')
  s.add_dependency('faraday-multipart')
  s.add_dependency('faraday-retry', '~> 2.2.1')
  s.add_dependency('sorbet-runtime')
  s.add_development_dependency('minitest')
  s.add_development_dependency('minitest-focus')
  s.add_development_dependency('rake')
  s.add_development_dependency('rubocop', '~> 1.73.2')
  s.add_development_dependency('rubocop-minitest', '~> 0.37.1')
  s.add_development_dependency('sorbet')
  s.add_development_dependency('tapioca', '~> 0.16.11')
end

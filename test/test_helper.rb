require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require 'dotenv'
Dotenv.load

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'vcr'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/workspace'
require_relative '../lib/recipient'
require_relative '../lib/user'
require_relative '../lib/channel'

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
end

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes" # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body], # The http method, URI and body of a request all need to match
  }

  # Don't leave our token lying around in a cassette file.
  config.filter_sensitive_data("<BOT_TOKEN>") do
    ENV["BOT_TOKEN"]
  end

  config.filter_sensitive_data("<USER_TOKEN>") do
    ENV["USER_TOKEN"]
  end
end

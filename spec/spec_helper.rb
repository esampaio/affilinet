require 'simplecov'

SimpleCov.start do
  add_filter '/spec'
end if ENV["COVERAGE"]

require File.expand_path("../../lib/affilinet", __FILE__)
require 'rspec/autorun'
require 'affilinet'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = "random"
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

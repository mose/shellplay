$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'bundler'
require 'rspec/given'

if ENV['COV']
  require 'simplecov'
  SimpleCov.profiles.define :hpcli do
    add_filter '/vendor/'
    add_filter '/spec/'
  end
  SimpleCov.start :hpcli
else
  # require 'coveralls'
  # Coveralls.wear!

  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

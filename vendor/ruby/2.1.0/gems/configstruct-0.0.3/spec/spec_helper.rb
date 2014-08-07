$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'bundler'

if ENV['COV']
  require 'simplecov'
  SimpleCov.profiles.define :app do
    add_filter '/vendor/'
    add_filter '/spec/'
  end
  SimpleCov.start :app
else
  require 'coveralls'
  Coveralls.wear!

  # require "codeclimate-test-reporter"
  # CodeClimate::TestReporter.start
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Warning:
# I'm not an expert tester, and on this project I wanted to try
# a super-isolation way. So each spec is testing each method and
# uses a lock of stubbing and doubles. Up to now I find it quite
# convenient because it makes the interdependencies more obvious,
# and when something changes in the code the need for changes in
# the stubbing is an occasion to think about the whole architecture.
# Also, it doesn't lie about the coverage, by stubbing all things,
# a thing is not covered if not explicitely tested.

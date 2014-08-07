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
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

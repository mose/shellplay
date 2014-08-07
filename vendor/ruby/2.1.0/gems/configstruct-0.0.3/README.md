Configstruct
=============

[![Gem Version](https://img.shields.io/gem/v/configstruct.svg)](http://rubygems.org/gems/configstruct)
[![Build Status](https://img.shields.io/travis/mose/configstruct.svg)](https://travis-ci.org/mose/configstruct)
[![Coverage Status](https://img.shields.io/coveralls/mose/configstruct.svg)](https://coveralls.io/r/mose/configstruct?branch=master)
[![Dependency Status](https://img.shields.io/gemnasium/mose/configstruct.svg)](https://gemnasium.com/mose/configstruct)
[![Code Climate](https://img.shields.io/codeclimate/github/mose/configstruct.svg)](https://codeclimate.com/github/mose/configstruct)

----

This gem is a lib for managing configfile for cli applications, including

- call a setup of the config file if it does not exist
- edit configuration and update the config file

It's for now totally experimental, please do not use yet.

## Installation

Add this line to your application's Gemfile:

    gem 'configstruct'

## Usage

````ruby
require 'cliprompt'
class Config < ConfigStruct

  include Cliprompt

  def set_defaults
    super
    default :name, 'default'
    default :url, 'http://greenruby.org'
  end

  def setup
    values = {}
    output.puts Paint['Applicaton configuration.', :blue]
    values['api_id'] = guess 'API_CLIENT', 'What is your Client ID?'
    values['api_secret'] = guess 'API_SECRET', 'What is your Secret Key?'
    write values
  end

end
````

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Copyright
----------

(c) Copy is right, 2014 - mose - this code is distributed under MIT license


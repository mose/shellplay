require 'cliprompt'
require 'configstruct'
require 'fileutils'

module Shellplay
  class Config < ConfigStruct

    include Cliprompt

    def initialize(options = nil, input = STDIN, output = STDOUT)
      super(options = nil, input = STDIN, output = STDOUT)
    end

    def set_defaults
      default :basedir, File.join(ENV['HOME'], '.shellplay')
      super
    end

    def setup
      values = {}
      output.puts Paint['Create a new shellplay configuration:', :blue]
      values['editor'] = guess 'EDITOR', 'What is the path to launch your text editor?', 'vim'
      values['prompt'] = ask 'What is the default prompt you want to use?', "\e[36m #{ENV['USER']} > \e[0m"
      values['timeformat'] = ask 'What is the time format you want to display?', '%.1f'
      write values
    end

  end
end

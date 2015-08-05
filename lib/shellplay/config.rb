require 'cliprompt'
require 'configstruct'
require 'fileutils'

# config struct class
# refer to https://github.com/mose/configstruct for documentation
module Shellplay
  class Config < ConfigStruct

    include Cliprompt

    def initialize(options = nil, input = STDIN, output = STDOUT)
      super(options, input = STDIN, output = STDOUT, true)
    end

    # override default config values
    def set_defaults
      default :basedir, File.join(ENV['HOME'], '.shellplay')
      default :basefile, File.join(self.basedir, 'config.yml')
      super
    end

    # interactive configuration creation process
    # uses cliprompt for console interaction
    # refer to https://github.com/mose/cliprompt for documentation
    def setup
      unless self.prompt && self.timeformat
        values = {}
        output.puts Paint['Create a new shellplay configuration:', :blue]
        #values['editor'] = guess 'EDITOR', 'What is the path to launch your text editor?', 'vim'
        values['prompt'] = ask 'What is the default prompt you want to use?', "\e[36m #{ENV['USER']} > \e[0m"
        values['timeformat'] = ask 'What is the time format you want to display?', '%.1f'
        write values
      end
    end

  end
end

require 'cliprompt'
require 'configstruct'

module Shellplay
  class Config < ConfigStruct

    include Cliprompt

    def set_defaults
      default :basedir, File.join(ENV['HOME'], '.shellplay')
      super
    end

    def setup
      values = {}
      output.puts Paint['Create a new shellplay configuration:', :blue]
      values['editor'] = guess 'EDITOR', 'What is the path to launch your text editor?', 'vim'
      values['prompt'] = ask 'What is the default prompt you want to use?'
      write values
    end

  end
end

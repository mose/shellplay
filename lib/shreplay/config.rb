require 'cliprompt'
require 'configstruct'

module Shreplay
  class Config < ConfigStruct

    include Cliprompt

    def set_defaults
      default :basedir, File.join(ENV['HOME'], '.shreplay')
      super
    end

    def setup
      values = {}
      output.puts Paint['Create a new shreplay configuration:', :blue]
      values['editor'] = guess 'EDITOR', 'What is the path to launch your text editor?', 'vim'
      values['prompt'] = ask 'What is the default prompt you want to use?'
      write values
    end

  end
end

require "cliprompt"
require "json"

require "shreplay/config"
require "shreplay/screen"

module Shreplay
  class Session

    include Cliprompt

    attr_reader :title, :config, :pointer

    def initialize(input = STDIN, output = STDOUT)
      @sequence = []
      @name = false
      @title = false
      @config = Shreplay::Config.new(nil, input, output)
      @pointer = 0
    end

    def import(file)
      data = JSON.parse(IO.read(file))
      @title = data['title']
      data['sequence'].each do |screenhash|
        add_screen(screenhash)
      end
    end

    def add_screen(screenhash)
      s = Shreplay::Screen.new
      s.import(screenhash)
      @sequence << s
    end

    def next
      @pointer += 1
    end

    def save
      prepare
      h = {}
      h[:title] = @title
      h[:sequence] = @sequence.map(&:export)
      outfile = File.join(@config.basedir, "#{@name}.json")
      File.open(outfile, 'w') do |f|
        f.write JSON.dump(h)
      end
    end

    def prepare
      set_title
      set_name
    end

  private

    def set_title
      @title ||= ask("What is the title of this session?", "No Title")
    end

    def set_name
      @name ||= ask("What is the name of the session file?", "untitled")
    end

  end
end

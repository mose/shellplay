require "cliprompt"
require "json"

require "shellplay/config"
require "shellplay/screen"

module Shellplay
  class Session

    include Cliprompt

    attr_reader :title, :config, :pointer, :sequence

    def initialize(input = STDIN, output = STDOUT)
      @sequence = []
      @title = false
      @config = Shellplay::Config.new(nil, input, output)
      @pointer = 0
    end

    def import(name)
      name ||= ask "What session do you want to load?",
        aslist: true,
        choices: Dir.glob(File.join(@config.basedir, '*.json')).map { |f| File.basename(f, '.json') }
      infile = File.join(@config.basedir, "#{name}.json")
      data = JSON.parse(IO.read(infile))
      @title = data['title']
      data['sequence'].each do |screenhash|
        add_screen(screenhash)
      end
    end

    def add_screen(screenhash)
      s = Shellplay::Screen.new
      s.import(screenhash)
      @sequence << s
    end

    def drop_last_screen
      @sequence.pop
      @pointer -= 1
    end

    def next
      @pointer += 1
    end

    def show(index)
      @pointer = index.to_i
      current_screen
    end

    def current_screen
      @sequence[@pointer]
    end

    def save
      prepare
      h = {}
      h[:title] = @title
      h[:sequence] = @sequence.map(&:export)
      outfile = File.join(@config.basedir, "#{@name}.json")
      File.open(outfile, 'w') do |f|
        f.write JSON.pretty_generate(h)
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

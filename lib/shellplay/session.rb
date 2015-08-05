require "cliprompt"
require "json"
require "open-uri"

require "shellplay/config"
require "shellplay/screen"

module Shellplay
  class Session

    include Cliprompt

    attr_reader :title, :name, :config, :pointer, :sequence, :prompt, :timeformat

    def initialize(basedir = nil, basefile = nil, input = STDIN, output = STDOUT)
      @sequence = []
      @name = false
      @title = false
      @prompt = false
      @timeformat = false
      @pointer = 0
      @basedir = basedir || File.join(ENV['HOME'], '.shellplay')
      FileUtils.mkdir_p(@basedir) unless Dir.exist? @basedir
      @basefile = basefile || 'config.yml'
      @input = input
      @output = output
    end

    def import(name)
      unless name
        sessions = Dir.glob(File.join(@basedir, '*.json'))
        if sessions.count == 0
          @output.puts "There is no recorded session locally."
          @output.puts "Do you want to play a remote recording?"
          name = ask "url: "
        else
          @output.puts "What session do you want to load?"
          name = ask "(input a number or an url if you want to play a remote recording)",
            aslist: true,
            choices: sessions.map { |f| File.basename(f, '.json') }
        end
      end
      if /^https?:\/\//.match name
        infile = open(name) { |f| f.read }
        @name = File.basename(name, '.json')
      else
        infile = IO.read(File.join(@basedir, "#{name}.json"))
        @name = name
      end
      data = JSON.parse(infile)
      @title = data['title']
      @config = Shellplay::Config.new({
        basedir: @basedir,
        basefile: File.join(@basedir, @basefile),
        prompt: data['prompt'],
        timeformat: data['timeformat'] }, input, output)
      data['sequence'].each do |screenhash|
        add_screen(screenhash)
      end
    end

    def add_screen(screenhash)
      s = Shellplay::Screen.new
      s.import(screenhash)
      @sequence << s
    end

    def add_screens(screenarray)
      @sequence += screenarray
    end

    def drop_last_screen
      @sequence.pop
      previous
    end

    def next
      @pointer += 1
    end

    def previous
      @pointer -= 1
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
      outfile = File.join(@basedir, "#{@name}.json")
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

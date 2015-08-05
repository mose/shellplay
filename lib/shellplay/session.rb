require "cliprompt"
require "json"
require "open-uri"

require "shellplay/config"
require "shellplay/screen"

# session class, controlling the interaction during the presentation
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

    # import a json file from local drive or http location
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

    # appends a screen to the main sequence
    def add_screen(screenhash)
      s = Shellplay::Screen.new
      s.import(screenhash)
      @sequence << s
    end

    # appends an array of screens to the sequence
    def add_screens(screenarray)
      @sequence += screenarray
    end

    # used for cancelling a screen while recording
    def drop_last_screen
      @sequence.pop
      previous
    end

    # jump to next screen
    def next
      @pointer += 1
    end

    # jump to previous screen
    def previous
      @pointer -= 1
    end

    # jump to an arbitrary screen
    def show(index)
      @pointer = index.to_i
      current_screen
    end

    # returns the screen object at the current point in the sequence
    def current_screen
      @sequence[@pointer]
    end

    # saves the json file for the sequence
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

    # initialize the sequence meta-data
    def prepare
      set_title
      set_name
    end

  private

    # uses cliprompt to ask for a title if not set already
    def set_title
      @title ||= ask("What is the title of this session?", "No Title")
    end

    # uses cliprompt to ask for a name if not set already
    # name is the name of the file on the disk
    def set_name
      @name ||= ask("What is the name of the session file?", "untitled")
    end

  end
end

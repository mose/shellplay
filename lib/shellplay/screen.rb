module Shellplay
  class Screen

    attr_reader :stdin, :stdout, :stderr, :display, :timespent, :displaycommand, :playprompt, :clearscreen

    def initialize
      @displaycommand = true
      @playprompt = true
      @clearscreen = false
      @stdin = nil
      @stdout = nil
      @stderr = nil
      @timespent = 0
    end

    def import(hash)
      @displaycommand = !!hash['displaycommand']
      @playprompt = !!hash['playprompt']
      @clearscreen = !!hash['clearscreen']
      @stdin = hash['stdin']
      @stdout = hash['stdout']
      @stderr = hash['stderr']
      @timespent = hash['timespent']
    end

    def export
      {
        displaycommand: @displaycommand,
        playprompt: @playprompt,
        clearscreen: @clearscreen,
        stdin: @stdin,
        stdout: @stdout,
        stderr: @stderr,
        timespent: @timespent
      }
    end

  end
end

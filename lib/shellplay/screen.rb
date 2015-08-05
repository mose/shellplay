# class for the screen object
module Shellplay
  class Screen

    attr_reader :stdin, :stdout, :stderr, :display, :timespent, :displaycommand, :playprompt, :clearscreen, :customprompt

    def initialize
      @displaycommand = true
      @playprompt = true
      @clearscreen = false
      @customprompt = nil
      @stdin = nil
      @stdout = nil
      @stderr = nil
      @timespent = 0
    end

    # transforms a hash into a screen object
    def import(hash)
      @displaycommand = !!hash['displaycommand']
      @playprompt = !!hash['playprompt']
      @clearscreen = !!hash['clearscreen']
      @customprompt = hash['customprompt']
      @stdin = hash['stdin']
      @stdout = hash['stdout']
      @stderr = hash['stderr']
      @timespent = hash['timespent']
    end

    # transfroms a screen object into a hash
    def export
      {
        displaycommand: @displaycommand,
        playprompt: @playprompt,
        clearscreen: @clearscreen,
        customprompt: @customprompt,
        stdin: @stdin,
        stdout: @stdout,
        stderr: @stderr,
        timespent: @timespent
      }
    end

  end
end

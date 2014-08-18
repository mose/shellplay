require "shell2html"

module Shellplay
  class Screen

    include Shell2html

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

    def html
      to_html(@stdout)
    end

  end
end

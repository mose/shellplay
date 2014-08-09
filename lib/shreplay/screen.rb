module Shreplay
  class Screen

    attr_reader :stdin, :stdout, :stderr, :display, :timespent

    def initialize
      @displaycommand = true
      @stdin = nil
      @stdout = nil
      @stderr = nil
      @timespent = 0
    end

    def import(hash)
      @displaycommand = hash['displaycommand']
      @stdin = hash['stdin']
      @stdout = hash['stdout']
      @stderr = hash['stderr']
      @timespent = hash['timespent']
    end

  end
end

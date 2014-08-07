require_relative 'lib/cliprompt'

class Myclass
  include Cliprompt

  def initialize
  end

  def askit
    puts '-------------------'
    puts 'numeric default'
    show "what is your age?", 42
    show "what is your size?", 6.2
    puts '-------------------'
    puts 'Free form'
    show "This simply ask for a simple form mandatory thing?"
    show "This simply ask for a simple form mandatory thing?", 'with a default'
    show "This simply ask for a simple form mandatory thing?", default: 'with a default again'
    puts '-------------------'
    puts 'yes/no'
    show 'a boolean?', 'y/N'
    show 'a boolean?', 'yN'
    show 'a boolean?', 'yesno'
    show 'a boolean?', 'yesNo'
    show 'a boolean?', boolean: true
    show 'a boolean?', boolean: true, default: false
    puts '-------------------'
    puts 'a list of choices'
    show 'a list without default?', [22, 33, 44, '55']
    show 'a list with default?', ['22', '33', '=44', '55']
    show 'a list without default?', choices: ['22', '33', '44', '55'], default: 22
    show 'a list with default?', choices: ['22', 33, '=44', '55']
  end

  def guessit
    puts '-------------------'
    showguess 'SOMEVAR', "what is your var?"
    showguess 'SOMEVAR', "what is your var?", 42
    showguess 'SOMEVAR', "what is your var?", boolean: true
    showguess 'SOMEVAR', "what is your var?", [12, 'aa']
  end

  def biglist
    puts '-------------------'
    puts 'a long list of choices'
    show 'a list with default?', [22, 33, 44, '=55', 66, 77, 'something else']
    show 'a list without default?', [22, 33, 44, '55', 66, 77, 'something else']
    show 'a big list of choices but not in list?', choices: [22, 33, 44, '=55', 66, 77, 'something else'], aslist: false
    show 'a small list of choices but we want it in list?', choices: [22, 33, '=44'], aslist: true
  end

  def show(*args)
    it = ask *args
    puts "-- returned #{it.inspect}"
    puts
  end

  def showguess(*args)
    it = guess *args
    puts "-- returned #{it.inspect}"
    puts
  end

end

m = Myclass.new
m.guessit
m.askit
m.biglist

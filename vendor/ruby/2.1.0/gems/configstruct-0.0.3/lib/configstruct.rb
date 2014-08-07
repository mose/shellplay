require 'ostruct'
require 'yaml'

class ConfigStruct < OpenStruct

  def initialize(options = nil, input = STDIN, output = STDOUT)
    super(options)
    @input = input
    @output = output
    set_defaults
    prepare_dirs
    addvalues
  end

  def set_defaults
    default :basedir, '/tmp'
    default :basefile, File.join(self.basedir, 'config.yml')
  end

  def prepare_dirs
    FileUtils.mkdir_p self.basedir unless Dir.exist? self.basedir
  end

  def addvalues
    setup unless File.exist? self.basefile
    YAML.load_file(self.basefile).each do |k, v|
      new_ostruct_member(k)
      send("#{k}=", v)
    end
  end

  def setup
    write Hash.new
  end

  def default(var, value)
    send(var).nil? && send("#{var}=", value)
  end

  def write(values)
    File.open(self.basefile, 'w') do |f|
      f.write YAML.dump(values)
    end
  end

  def puts(*string)
    @output.puts *string
  end

  def print(*string)
    @output.print *string
  end

  def printf(string, *args)
    @output.printf string, *args
  end

  def gets(*args)
    @input.gets *args
  end

end

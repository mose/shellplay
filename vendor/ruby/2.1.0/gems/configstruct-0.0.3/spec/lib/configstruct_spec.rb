# encoding: utf-8

require 'spec_helper'
require 'configstruct'

describe ConfigStruct do

  let(:basedir) { File.expand_path('../../files', __FILE__) }
  let(:basefile) { File.expand_path('../../files/config.yml', __FILE__) }
  let(:options) { { basedir: basedir, basefile: basefile } }
  let(:value1) { 'newdefault' }

  describe '.default' do
    subject { ConfigStruct.new options }
    before { subject.default :var, value1 }
    it { expect(subject.var).to eq value1 }
  end

  describe '.new' do
    context 'when there is no config file, ' do
      let(:basefile) { File.expand_path('../../files/xxx.yml', __FILE__) }
      after { FileUtils.rm basefile if File.exist? basefile }
      subject { ConfigStruct.new options }
      it 'then a config file is created calling' do
        expect(subject.basefile).to eq basefile
        expect(File.exist? basefile).to be_true
      end
    end
  end

  describe 'output/input override' do
    let(:input) { StringIO.new }
    let(:output) { StringIO.new }
    let(:str) { "xxx" }
    subject { ConfigStruct.new options, input, output }
    context "when single string is used" do
      it 'redirect puts to StringIO object' do
        subject.puts str
        expect(output.string).to eq "#{str}\n"
      end
      it 'redirect print to StringIO object' do
        subject.print str
        expect(output.string).to eq str
      end
      it 'redirect printf to StringIO object' do
        subject.printf "-- %s --", str
        expect(output.string).to eq "-- #{str} --"
      end
      it 'redirect gets to StringIO object' do
        input.stub(:gets).and_return(str)
        expect(subject.gets).to eq str
      end
    end
    context "when multiple strings are used" do
      let(:str2) { "zzz" }
      it 'redirect puts to StringIO object' do
        subject.puts str, str2
        expect(output.string).to eq "#{str}\n#{str2}\n"
      end
      it 'redirect print to StringIO object' do
        subject.print str, str2
        expect(output.string).to eq "#{str}#{str2}"
      end
      it 'redirect printf to StringIO object' do
        subject.printf "-- %s -- %s --", str, str2
        expect(output.string).to eq "-- #{str} -- #{str2} --"
      end
    end
  end

end

require 'spec_helper'

require "shreplay/screen"

describe Shreplay::Screen, "A typical screen element" do

  let(:goodhash) {
    {
      "timespent" => 0.123,
      "stdin" => "ls -1",
      "stdout" => "bin\nCHANGELOG.md\nGemfile\n"
    }
  }

  subject { Shreplay::Screen.new }

  describe ".import" do

    context "when we import a valid hash, " do
      before  { subject.import(goodhash) }
      it "fills up instance variables from a hash" do
        expect(subject.stdin).to eq goodhash['stdin']
      end
    end

    context "when we import an empty hash, " do
      before  { subject.import({}) }
      it "inits the variables with false values" do
        expect(subject.stdin).to be_falsey
      end
    end

  end

end

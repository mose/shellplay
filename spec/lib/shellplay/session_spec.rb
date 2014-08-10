require 'spec_helper'

require "shellplay/session"

describe Shellplay::Session, "A shellplay session" do

  let(:sessionfile) { File.expand_path('../../../files/session.json', __FILE__)}
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  subject { Shellplay::Session.new(input, output) }

  describe '.new' do
    context 'when there is no prior configuration file, ' do
    end
  end

  describe ".import" do

    context "when we import a valid file, " do
      before  { subject.import(sessionfile) }
      it "fills up instance variables from the file" do
        expect(subject.title).to eq "test prez"
      end
    end

    context "when we import an invalid file, " do
      it "should break and throw exception" do
        expect { subject.import('/file/notfound') }.to raise_error
      end
    end

  end

end

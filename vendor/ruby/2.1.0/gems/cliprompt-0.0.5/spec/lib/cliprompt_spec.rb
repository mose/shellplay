# encoding: utf-8

require 'spec_helper'
require 'cliprompt'
require 'cliprompt/optionset'

describe Cliprompt do
  Given(:input) { StringIO.new }
  Given(:output) { StringIO.new }
  Given { subject.setio(input, output) }

  describe '.ask' do
    Given(:question) { 'wazza?' }
    Given(:answer) { 'xxx' }
    context 'without default,' do
      When(:args) { }
      When { input.stub(:gets).and_return answer }
      Then { expect(subject.ask(question, args)).to eq answer }
      And  { expect(output.string).to eq "#{question} " }
    end
    context 'with a default,' do
      When(:default) { 'ooo' }
      When(:args) { { default: default } }
      When { input.stub(:gets).and_return answer }
      Then { expect(subject.ask(question, args)).to eq answer }
      And  { expect(output.string).to eq "#{question} [#{default}] " }
    end
    context 'with an optionset,' do
      When(:args) { Cliprompt::Optionset.new() }
      When { input.stub(:gets).and_return answer }
      Then { expect(subject.ask(question, args)).to eq answer }
      And  { expect(output.string).to eq "#{question} " }
    end
    context 'with choices requested as a list,' do
      When(:args) { { choices: ['aaa', 'bbb', 'ccc'], aslist: true } }
      When { input.stub(:gets).and_return '1' }
      Then { expect(subject.ask(question, args)).to eq 'bbb' }
      And  { expect(output.string).to eq "#{question} \n  0   aaa\n  1   bbb\n  2   ccc\n#{Cliprompt::MSG_CHOSE_A_NUMBER} " }
    end
    context 'with choices requested as a list with a default,' do
      When(:args) { { choices: ['=aaa', 'bbb', 'ccc'], aslist: true } }
      When { input.stub(:gets).and_return '' }
      Then { expect(subject.ask(question, args)).to eq 'aaa' }
      And  { expect(output.string).to eq "#{question} \n> 0   aaa\n  1   bbb\n  2   ccc\n#{Cliprompt::MSG_CHOSE_A_NUMBER} [0] " }
    end
    context 'with choices requested as a non-list despite there are many choices,' do
      When(:args) { { choices: %w(aaa bbb ccc ddd eee fff), aslist: false } }
      When { input.stub(:gets).and_return 'bbb' }
      Then { expect(subject.ask(question, args)).to eq 'bbb' }
      And  { expect(output.string).to eq "#{question} (aaa / bbb / ccc / ddd / eee / fff) " }
    end
    context 'with a big list of choices,' do
      When(:args) { %w(aaa bbb ccc ddd eee fff) }
      When { input.stub(:gets).and_return '5' }
      Then { expect(subject.ask(question, args)).to eq 'fff' }
      And  { expect(output.string).to eq "#{question} \n  0   aaa\n  1   bbb\n  2   ccc\n  3   ddd\n  4   eee\n  5   fff\n#{Cliprompt::MSG_CHOSE_A_NUMBER} " }
    end
  end

  describe '.guess' do
    Given(:question) { 'wazza?' }
    Given(:env_var) { 'SOMEVAR' }
    Given(:args) { }
    context 'when env var is provided,' do
      When(:env_value) { 'xxx' }
      When { ENV[env_var] = env_value }
      Then { expect(subject.guess(env_var, question, args)).to eq env_value }
      And  { ENV.delete(env_var) }
    end
    context 'when env var is not provided,' do
      When(:answer) { 'ooo' }
      When { input.stub(:gets).and_return answer }
      Then { expect(subject.guess(env_var, question, args)).to eq answer }
      And  { expect(output.string).to eq "#{question} " }
    end
  end

  describe '.say' do
    Given(:msg) { "hah" }
    When { subject.say msg }
    Then { expect(output.string).to eq "#{msg}\n" }
  end

  describe '.shout' do
    Given(:msg) { "hah" }
    When { subject.shout msg }
    Then { expect(output.string).to eq "#{Paint[msg, :bold, :red ]}\n" }
  end

end

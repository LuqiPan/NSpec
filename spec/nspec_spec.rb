require 'treetop'
require 'pry'
require 'spec_helper'
Treetop.load 'NSpec'

shared_examples "an accepted sentence" do
  it 'is a SyntaxNode' do
    result = parser.parse(subject)
    expect(result).to be_a(Treetop::Runtime::SyntaxNode)
  end
end

shared_examples "a unaccepted sentence" do
  it 'is not a SyntaxNode' do
    result = parser.parse(subject)
    expect(result).to be_nil
  end
end

describe NSpec do
  let(:parser) { NSpecParser.new }

  describe 'parse the sentence' do
    with_pairs = [
      ['basic: white spaces', 'expect it to be equal 5'],
      ['basic: not', 'expect it not to be equal 5'],
      ['variable containing underscore', 'expect var_ to be equal something'],
      ['variable containing number', 'expect var1 to be equal something'],
      ['variable containing both underscore and number', 'expect var_1 to be equal s'],
      ['identity', 'expect it to be 5'],
      ['equivalence: eq', 'expect it to eq 5'],
      ['equivalence: eql', 'expect it to eql 5'],
      ['equivalence: equal', 'expect it to equal 5'],
    ]
    without_pairs = [
      ['be', 'expect it not to equal 5'],
    ]
    with_pairs.each do |pair|
      context "with #{pair[0]}" do
        subject { pair[1] }
        it_behaves_like 'an accepted sentence'
      end
    end

    without_pairs.each do |pair|
      context "without #{pair[0]}" do
        subject { pair[1] }
        it_behaves_like 'an accepted sentence'
      end
    end
  end

  describe "doesn't parse the sentence" do
    pairs = [
      ['with 2 nots', 'expect it not not to be equal 5']
    ]
    pairs.each do |pair|
      context pair[0] do
        subject { pair[1] }
        it_behaves_like 'a unaccepted sentence'
      end
    end
  end
end

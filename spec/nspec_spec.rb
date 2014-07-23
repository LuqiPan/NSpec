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
      ['with white spaces', 'expect (it) to be equal 5'],
      ['with not', 'expect (it) not to be equal 5'],
      ['with variable containing underscore', 'expect (var_) to be equal something'],
      ['with variable containing number', 'expect (var1) to be equal something'],
      ['with variable containing both underscore and number', 'expect (var_1) to be equal s']
    ]
    without_pairs = [
      ['without be', 'expect (it) not to equal 5'],
      ['without space after expect', 'expect(it) to eq 5'],
      ['without space after actual', 'expect(it)to eq 5']
    ]
    (with_pairs + without_pairs).each do |pair|
      context pair[0] do
        subject { pair[1] }
        it_behaves_like 'an accepted sentence'
      end
    end
  end

  describe "doesn't parse the sentence" do
    pairs = [
      ['with 2 nots', 'expect (it) not not to be equal 5']
    ]
    pairs.each do |pair|
      context pair[0] do
        subject { pair[1] }
        it_behaves_like 'a unaccepted sentence'
      end
    end
  end
end

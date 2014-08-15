require 'treetop'
require 'pry'
require 'pry-nav'
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
    with_examples = [
      # Primitives
      # [describe string, NSpec syntax example]
      ['basic: white spaces', 'expect actual to be equal 5'],
      ['basic: not', 'expect actual not to be equal 5'],
      ['variable containing underscore', 'expect var_ to be equal something'],
      ['variable containing number', 'expect var1 to be equal something'],
      ['variable containing both underscore and number', 'expect var_1 to be equal s'],
      # RSpec syntax
      ['identity', 'expect actual to be 5'],
      ['equivalence: eq', 'expect actual to eq 5'],
      ['equivalence: eql', 'expect actual to eql 5'],
      ['equivalence: equal', 'expect actual to equal 5'],
      ['comparison: >', 'expect actual to be > 5'],
      ['comparison: >=', 'expect actual to be >= 5'],
      ['comparison: <', 'expect actual to be < 5'],
      ['comparison: <=', 'expect actual to be <= 5'],
      ['comparison: between inclusive', 'expect actual to be between 1 5 inclusive'],
      ['comparison: between exclusive', 'expect actual to be between 1 5 exclusive'],
      ['comparison: match', 'expect actual to match regex'],
      ['comparison: within', 'expect actual to be within 1 of 5'],
      ['comparison: start with', 'expect actual to start with 1'],
      ['comparison: end with', 'expect actual to end with 1'],
      ['type/class: instance of', 'expect actual to be instance of 5'],
      ['type/class: kind of', 'expect actual to be kind of 5'],
      ['response: respond to', 'expect actual to respond to method'],
      # TODO: it also matches the identity, so check it later
      ['truthiness: truthy', 'expect actual to be truthy'],
      ['truthiness: falsey', 'expect actual to be falsey'],
      ['existence: exist', 'expect actual to exist'],
      ['errors: raise error', 'expect actual to raise error'],
      ['throw: throw symbol', 'expect actual to throw symbol'],
      ['predicate: have', 'expect actual to have something'],
    ]
    without_examples = [
      ['be', 'expect actual not to equal 5'],
    ]
    with_examples.each do |example|
      context "with #{example[0]}" do
        subject { example[1] }
        it_behaves_like 'an accepted sentence'
      end
    end

    without_examples.each do |example|
      context "without #{example[0]}" do
        subject { example[1] }
        it_behaves_like 'an accepted sentence'
      end
    end
  end

  describe "doesn't parse the sentence" do
    invalid_examples = [
      ['with 2 nots', 'expect actual not not to be equal 5']
    ]
    invalid_examples.each do |example|
      context example[0] do
        subject { example[1] }
        it_behaves_like 'a unaccepted sentence'
      end
    end
  end

  describe 'rewrite the sentence' do
    examples = [
      ['identity', 'expect actual to be 5', 'expect(actual).to be(5)'],
      ['equivalence: eq', 'expect actual to eq 5', 'expect(actual).to eq(5)'],
      ['equivalence: eql', 'expect actual to eql 5', 'expect(actual).to eql(5)'],
      ['equivalence: equal', 'expect actual to equal 5', 'expect(actual).to equal(5)'],
      ['comparison: >', 'expect actual to be > 5', 'expect(actual).to be > 5'],
      ['comparison: >=', 'expect actual to be >= 5', 'expect(actual).to be >= 5'],
      ['comparison: <', 'expect actual to be < 5', 'expect(actual).to be < 5'],
      ['comparison: <=', 'expect actual to be <= 5', 'expect(actual).to be <= 5'],
      ['comparison: match', 'expect actual to match regex', 'expect(actual).to match(regex)'],
      ['comparison: start with', 'expect actual to start with 1', 'expect(actual).to start_with 1'],
      ['comparison: end with', 'expect actual to end with 1', 'expect(actual).to end_with 1'],
      ['type/class: instance of', 'expect actual to be instance of 5', 'expect(actual).to be_instance_of(5)'],
      ['type/class: kind of', 'expect actual to be kind of 5', 'expect(actual).to be_kind_of(5)'],
      ['response: respond to', 'expect actual to respond to method', 'expect(actual).to respond_to(method)'],
    ]
    examples.each do |example|
      it "rewrites #{example[1]}" do
        #puts parser.parse(example[1]).inspect
        expect(parser.parse(example[1]).rewrite).to eq example[2]
      end
    end
  end
end

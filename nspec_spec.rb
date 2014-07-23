require 'treetop'
require 'pry'
Treetop.load 'NSpec'

shared_examples "an accepted sentence" do
  it 'is a SyntaxNode' do
    result = parser.parse(subject)
    expect(result).to be_a(Treetop::Runtime::SyntaxNode)
  end
end

describe NSpec do
  let(:parser) { NSpecParser.new }
  let(:sentence) { 'not gonna happen' }

  describe 'parse the sentence' do
    context 'with white spaces' do
      subject { 'expect (it) to be equal 5' }
      it_behaves_like 'an accepted sentence'
    end

    it 'parse the sentence with not' do
      result = parser.parse('expect (it) not to be equal 5')
      expect(result).to be_a(Treetop::Runtime::SyntaxNode)
    end

    it 'be can be optional' do
      result = parser.parse('expect (it) not to equal 5')
      expect(result).to be_a(Treetop::Runtime::SyntaxNode)
    end

    it "doesn't parse 2 'not's" do
      result = parser.parse('expect (it) not not to be equal 5')
      expect(result).to be_nil
    end

    it 'also works with variable with underscore' do
      result = parser.parse('expect (var_) to be equal something')
      expect(result).to be_a(Treetop::Runtime::SyntaxNode)
    end

    it 'also works with variable with number' do
      result = parser.parse('expect (var1) to be equal something')
      expect(result).to be_a(Treetop::Runtime::SyntaxNode)
    end
  end
end

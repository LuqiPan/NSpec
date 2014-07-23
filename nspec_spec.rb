require 'treetop'
require 'pry'
Treetop.load 'NSpec'

describe NSpec do
  let(:parser) { NSpecParser.new }

  it 'parse the sentence with white spaces' do
    result = parser.parse('expect (it) to be equal 5')
    expect(result).to be_a(Treetop::Runtime::SyntaxNode)
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
end

require 'treetop'
require 'pry'
Treetop.load 'NSpec'

describe NSpec do
  let(:parser) { NSpecParser.new }

  it 'parses the sentence without some white spaces' do
    result = parser.parse('expect(it) to be equal 5')
    expect(result).to be_a(Treetop::Runtime::SyntaxNode)
  end

  it 'parse the sentence with white spaces' do
    result = parser.parse('expect (it) to be equal 5')
    expect(result).to be_a(Treetop::Runtime::SyntaxNode)
  end
end

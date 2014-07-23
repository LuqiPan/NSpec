require 'treetop'
require 'pry'
Treetop.load 'NSpec'

describe NSpec do
  describe 'it should load' do
    it 'works' do
      parser = NSpecParser.new
      result = parser.parse('expect(it) to ')
      puts result
      expect(result).to be_a(Treetop::Runtime::SyntaxNode)
    end
  end
end

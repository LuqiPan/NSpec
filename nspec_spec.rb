require 'treetop'
require 'pry'
Treetop.load 'NSpec'

describe NSpec do
  describe 'it should load' do
    it 'works' do
      parser = NSpecParser.new
      puts parser.parse('hello')
    end
  end
end

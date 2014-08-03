require 'treetop'
require 'pry'
Treetop.load 'NSpec'

class NSpecRewriter
  def initialize
    @nspec_parser = NSpecParser.new
  end

  def parse(sentence)
    @nspec_parser.parse(sentence)
  end

  def parse_to_s(sentence)
    ast = parse(sentence)
    binding.pry
  end
end

require 'treetop'
require 'pry'
Treetop.load 'NSpec'

class NSpecRewriter
  def inititialize
    parser = NSpecParser.new
  end

  def parse(sentence)
    parser.parse(sentence)
  end

  def parse_to_s(sentence)
    ast = parse(sentence)
    ast.to_s
  end
end

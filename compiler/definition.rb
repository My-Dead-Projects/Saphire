
class Definition
  attr_accessor :start, :end, :type, :symbol, :hash, :code
  def initialize(type=nil, symbol=nil, hash={})
    @type = type
    @symbol = symbol
    @hash = hash
  end
end
Def = Definition

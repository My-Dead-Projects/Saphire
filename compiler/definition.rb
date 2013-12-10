
class Definition
  attr_accessor :start, :end, :type, :identifier, :hash, :code
  def initialize(type=nil, identifier=nil, hash={})
    @type = type
    @identifier = identifier
    @hash = hash
    @code = []
  end
end
Def = Definition


class Definition
  attr_accessor :start, :end, :type, :id, :hash, :code
  def initialize(type=nil, id=nil, hash={})
    @type = type
    @id = id
    @hash = hash
    @code = []
  end
end
Def = Definition

class CodeElement
  attr_accessor :id
  def initialize(id)
    @id = id
  end
  def inspect
    "<#{self.class.inspect}:'#{id}'>"
  end
end

class MethodCall < CodeElement
  attr_accessor :arguments
  def initialize(id, arguments=[])
    super(id)
    @arguments = arguments
  end
end

class ScopedVariable < CodeElement
  
end

class InstanceVariable < CodeElement
  
end

class ClassVariable < CodeElement
  
end

class Operator < CodeElement
  
end

class NumericLiteral < CodeElement
  
end

class StringLiteral < CodeElement
  
end

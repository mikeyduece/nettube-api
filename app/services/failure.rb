class Failure
  attr_reader :message, :code
  
  def initialize(message, code)
    @message = message
    @code = code
  end
  
  def call(&block)
    yield(message, code)
  end
end
class BaseService
  def self.call(user, params, &block)
    new(user, params).call(&block)
  end
  
  def initialize(user, params)
    @user = user
    @params = params
  end
  
  private_class_method :new
  
  def call(&block)
    raise NotImplementedError
  end
  
  private
  
  attr_reader :user, :params
end
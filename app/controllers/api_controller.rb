class ApiController < ActionController::API
  include Serializable
  
  before_action :doorkeeper_authorize!
end
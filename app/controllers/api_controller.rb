class ApiController < ActionController::API
  include Serializable
  
  before_action :doorkeeper_authorize!

  delegate :t, to: I18n

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: "Not Authorized" } }
  end
  
  private
  
  def limit
    params[:limit] || 10
  end
  
  def offset
    params[:offset] || 0
  end
  
  def ensure_user_owns(resource, id, &block)
    if current_api_user.send(resource).find_by(id: id)
      yield
    else
      error_response("You must own the #{resource} to modify it", 404)
    end
  end

  def current_api_user
    @current_api_user ||= User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
module Serializable
  def serialized_resource(resource, blueprint, options = {})
    JSON.parse(blueprint.render(resource, options), symbolize_names: true)
  end
  
  def success_response(status = 200, data = {}, message = nil)
    response = default_response(status, message, data)
    render json: response
  end
  
  def error_response(message, status = 404)
    default_response = default_response(status, message)
    render json: default_response
  end
  
  def default_response(status, message, data = {})
    { status: status, message: message }.merge(data)
  end

end
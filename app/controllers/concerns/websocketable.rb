module Websocketable
  
  def broadcast_for_channel(channel, blueprint, resource)
    ActionCable.server.broadcast channel, hashable(blueprint, resource)
    head :ok
  end
  
  def broadcast_to_channel(channel, resource)
    channel.broadcast_to resource, hashable(blueprint, resource)
    head :ok
  end
  
  private
  
  def hashable(blueprint, resource)
    blueprint.render_as_hash(resource)
  end
end
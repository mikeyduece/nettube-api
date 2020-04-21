class PlaylistJob < ApplicationJob
  def perform(playlist)
    ActionCable.server.broadcast :playlists_channel, playlist: hashable(playlist)
  end
  
  def hashable(resource)
    resource.blueprint.render_as_hash(resource)
  end
end
class PlaylistRelayWorker
  include Sidekiq::Worker
  sidekiq_options retry: true, count: 3
  
  def perform(playlist_id)
    playlist = Playlist.find_by(id: playlist_id)

    ActionCable.server.broadcast :playlists_channel, playlist: hashable(playlist)
  end
  
  private
  
  def hashable(resource)
    resource.blueprint.render_as_hash(resource)
  end
end
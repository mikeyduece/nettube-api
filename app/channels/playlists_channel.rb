class PlaylistsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "playlists_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

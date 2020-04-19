class VideosChannel < ApplicationCable::Channel
  def subscribed
    playlist = Playlist.find(params[:playlist])
    stream_for playlist
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

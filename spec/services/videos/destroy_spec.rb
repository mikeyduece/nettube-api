require 'rails_helper'

describe 'Remove Video from Playlist' do
  it 'should remove videos from playlist' do
    playlist = create(:playlist_with_videos)
    video_to_be_deleted = playlist.videos.last
    
    expect(playlist.videos.count).to eq(5)
    
    video_service(:playlists_videos, :destroy, playlist.user, {playlist_id: playlist.id, id: video_to_be_deleted.id }) do |s,f|
      s.call do |resource|
        videos = resource.videos
        expect(videos.count).to eq(4)
        expect(videos.pluck[:id]).not_to include(video_to_be_deleted.id)
      end
    end
    
  end
  
end
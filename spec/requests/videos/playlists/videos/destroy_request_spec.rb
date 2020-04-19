require 'rails_helper'

describe 'Remove Videos' do
  let!(:user) { create(:user) }
  let!(:playlist) { create(:playlist_with_videos, user: user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  
  before(:each) do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
  end
  
  it 'should remove videos from playlist' do
    user = playlist.user
    video = playlist.videos.last
    
    delete api_v1_user_playlist_video_path(user.id, playlist.id, video.id)
    playlist_data = parse_json(response.body)
    
    expect(playlist_data[:playlist][:videos].count).to eq(4)
  end

  it 'should not allow users to remove videos from playlists they don\'t own' do
    user_2 = create(:user)
    playlist = create(:playlist_with_videos, user: user)
    video = playlist.videos.last
    token_2 = Doorkeeper::AccessToken.new(resource_owner_id: user_2.id)
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token_2)
  
    delete api_v1_user_playlist_video_path(user_2, playlist, video)
  
    expect(response).to be_successful
  
    playlist_data = parse_json(response.body)
  
    expect(playlist_data[:status]).to eq(404)
    expect(playlist_data[:message]).to eq('You must own the playlists to modify it')
  end
end
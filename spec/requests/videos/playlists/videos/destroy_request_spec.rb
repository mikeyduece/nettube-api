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
end
require 'rails_helper'

describe 'Create Playlist' do
  let!(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  let(:playlist_params) {
    { name: 'Playlist1',
      video: {
        etag: "string",
        youtube_id: "string_thing",
        img_high: "another_string",
        img_default: "default_string",
        title: "Title",
        published_at: DateTime.now,
        description: "It's a thing'"
      } }
  }

  before(:each) do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
  end

  it 'should create playlist' do
    post api_v1_user_playlists_path(user), params: { playlist: playlist_params }
    
    expect(response).to be_successful
    
    playlist_data = JSON.parse(response.body, symbolize_names: true)
    playlist = user.playlists.last
    
    expect(user.playlists.count).to eq(1)
    expect(playlist.name).to eq(playlist_params[:name])
    expect(playlist.name).to eq(playlist_data[:playlist][:name])
  end
end
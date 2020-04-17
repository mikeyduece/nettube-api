require 'rails_helper'

describe 'Add videos to playlist' do
  let!(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  let!(:playlist) { create(:playlist_with_videos, user: user) }
  let(:video_params1) {
    { playlist_id: playlist.id,
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
  
  let(:video_params2) {
    { playlist_id: playlist.id,
      video: {
      etag: "string2",
      youtube_id: "string_thing2",
      img_high: "another_string2",
      img_default: "default_string2",
      title: "Title2",
      published_at: DateTime.now,
      description: "It's a thing2"
    } }
  }
  
  it 'should create video when added to a Playlist' do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
    
    video_service(:playlists_videos, :create, user, video_params1) do |success, _failure|
      success.call do |resource|
        expect(resource).to be_a(Playlist)
        expect(resource.name).to eq(playlist_params[:playlist][:name])
      end
    end
  end
  
  it 'should add videos to playlist' do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
    
    post api_v1_user_playlist_videos_path(user.id, playlist.id), params: video_params1
    
    expect(response).to be_successful
    
    playlist_data = parse_json(response.body)
    
    playlist = user.playlists.last
    playlist_videos = playlist.videos
    
    expect(playlist_videos.count).to eq(6)
    expect(playlist_data[:playlist][:videos].count).to eq(6)
    expect(playlist_data[:playlist][:videos].last[:title]).to eq(video_params1[:video][:title])
  end
  
  it 'should only allow playlist owner to add videos' do
    user_2 = create(:user)
    token_2 = Doorkeeper::AccessToken.new(resource_owner_id: user_2.id)
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token_2)
    
    post api_v1_user_playlist_videos_path(user_2.id, playlist.id), params: video_params1
    
    expect(response).to be_successful
    
    playlist_data = parse_json(response.body)
    
    expect(playlist_data[:status]).to eq(404)
    expect(playlist_data[:message]).to eq('You can\'t add videos to a playlist you don\'t own')
  end
end
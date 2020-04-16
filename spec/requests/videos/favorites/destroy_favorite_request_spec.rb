require 'rails_helper'

describe 'Delete Favorite' do
  let!(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  let(:video_params1) {
    { video: {
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
    { video: {
      etag: "string2",
      youtube_id: "string_thing2",
      img_high: "another_string2",
      img_default: "default_string2",
      title: "Title2",
      published_at: DateTime.now,
      description: "It's a thing2"
    } }
  }
  
  before(:each) do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
    post api_v1_user_favorites_path(user), params: video_params1
  end

  it 'should delete favorites' do
    delete api_v1_user_favorite_path(user.id, Favorite.last.id)
    
    expect(response).to be_successful
    expect(Favorite.count).to eq(0)
  end

  it 'should only delete the specified favorite' do
    post api_v1_user_favorites_path(user), params: video_params2
    expect(Favorite.count).to eq(2)

    delete api_v1_user_favorite_path(user.id, Favorite.last.id)
    
    video = Favorite.last.video
    expect(Favorite.count).to eq(1)
    expect(video.title).to eq(video_params1[:video][:title])
  end
end
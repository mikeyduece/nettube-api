require 'rails_helper'

describe 'Video Service' do
  let(:user) { create(:user) }
  let(:video_params) {
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
  
  it 'should create video when favorited' do
    video_service(:favorites, :create, user, video_params) do |success, _failure|
      success.call do |resource|
        expect(resource).to be_a(Video)
        expect(Favorite.last.video_id).to eq(Video.last.id)
      end
    end
  end
end
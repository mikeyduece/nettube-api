require 'rails_helper'

describe 'Video Service' do
  let(:user) { create(:user) }
  let(:video_params) {
    {
      etag: "string",
      youtube_id: "string_thing",
      img_high: "another_string",
      img_default: "default_string",
      title: "Title",
      published_at: DateTime.now,
      description: "It's a thing'"
    }
  }
  
  let(:playlist_params) {
    {
      name: 'Playlist1',
      video: {
        etag: "string",
        youtube_id: "string_thing",
        img_high: "another_string",
        img_default: "default_string",
        title: "Title",
        published_at: DateTime.now,
        description: "It's a thing'"
      }
    }
  }
  
  context 'Favorites' do
    it 'should create video when favorited' do
      video_service(:favorites, :create, user, video_params) do |success, _failure|
        success.call do |resource|
          expect(resource).to be_a(Video)
          expect(Favorite.last.video_id).to eq(Video.last.id)
        end
      end
    end
  
  end
  
  context 'Playlists' do
    it 'should create video when added to a Playlist' do
      video_service(:playlists, :create, user, playlist_params) do |success, _failure|
        success.call do |resource|
          expect(resource).to be_a(Playlist)
          expect(resource.name).to eq(playlist_params[:playlist][:name])
          expect(Playlist.last.videos).to include(Video.last)
        end
      end
    end
    
    it 'should not create playlist with same same for same user' do
      video_service(:playlists, :create, user, playlist_params) do |success, _failure|
        success.call do |resource|
          expect(resource).to be_a(Playlist)
          expect(resource.name).to eq(playlist_params[:name])
          expect(Playlist.last.videos).to include(Video.last)
        end
      end
      
      video_service(:playlists, :create, user, playlist_params) do |_success, failure|
        expect(failure.message).to eq('You already have a playlist with that name')
      end
    end

    it 'should allow users to create more than one playlist' do
      video_service(:playlists, :create, user, playlist_params) do |success, _failure|
        success.call do |resource|
          expect(resource).to be_a(Playlist)
          expect(resource.name).to eq(playlist_params[:name])
          expect(Playlist.last.videos).to include(Video.last)
        end
      end

      video_service(:playlists, :create, user, { name: 'Playlist2' }) do |success, _failure|
        success.call do |resource|
          expect(resource).to be_a(Playlist)
          expect(resource.name).to eq('Playlist2')
        end
      end
    end

    it 'should allow playlists with name same for different users' do
      expect(Playlist.count).to eq(0)
      video_service(:playlists, :create, user, playlist_params) do |success, _failure|
        success.call do |resource|
          expect(resource).to be_a(Playlist)
          expect(resource.name).to eq(playlist_params[:name])
          expect(Playlist.last.videos).to include(Video.last)
        end
      end
      
      expect(Playlist.count).to eq(1)

      user_2 = create(:user)
      video_service(:playlists, :create, user_2, playlist_params) do |success, _failure|
        success.call do |resource|
          expect(resource).to be_a(Playlist)
          expect(resource.name).to eq(playlist_params[:name])
          expect(Playlist.last.videos).to include(Video.last)
        end
      end
      
      expect(Playlist.count).to eq(2)
      expect(user.playlists.count).to eq(1)
      expect(user_2.playlists.count).to eq(1)
    end
    
  end
end
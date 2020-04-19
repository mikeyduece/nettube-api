require 'rails_helper'

describe 'Update Playlist#view_status' do
  let(:user) { create(:user) }
  let(:playlist) { create(:playlist, user: user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  
  before(:each) do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
  end
  
  it 'should update view_status' do
    expect(playlist.closed?).to be(true)
    expect(playlist.open?).not_to be(true)
    
    put toggle_api_v1_user_playlist_path(user, playlist)
    
    expect(response).to be_successful
    
    expect(playlist.reload.open?).to be(true)
    expect(playlist.reload.closed?).not_to be(true)
  end
end
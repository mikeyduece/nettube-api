require 'rails_helper'

describe 'Show Playlists' do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let!(:playlist) { create(:playlist, user: user_2) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user_1.id) }

  before(:each) do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
  end
  
  it 'should not show to non friends when #closed?' do
    get api_v1_user_playlists_path(user_2)
    
    expect(response).to be_successful
    playlists = parse_json(response.body)
    
    expect(playlists[:playlists].count).to eq(0)
  end

  it 'should show to friends when #closed?' do
    user_2.friends << user_1
    user_1.friends << user_2
    get api_v1_user_playlists_path(user_2)
    
    playlists = parse_json(response.body)
    
    expect(playlists[:playlists].count).to eq(1)
  end
end
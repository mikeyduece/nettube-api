require 'rails_helper'

describe 'Show Favorites' do
  let!(:user) { create(:user) }
  let!(:favorites) { create_list(:favorite, 10, user: user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  
  it 'should list of favorites' do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
    get api_v1_user_favorites_path(user)
    
    expect(response).to be_successful
    
    favs = JSON.parse(response.body, symbolize_names: true)
    
    expect(favs[:favorites].count).to eq(10)
  end
end
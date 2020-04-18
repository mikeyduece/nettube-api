require 'rails_helper'

describe 'Friends' do
  let(:user_1) {create(:user)}
  let(:user_2) {create(:user)}
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user_1.id) }
  let(:token_2) { Doorkeeper::AccessToken.new(resource_owner_id: user_2.id) }
  
  before(:each) { allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token) }
  
  it 'should list friends' do
    user_1.friends << user_2
    get api_v1_user_friends_path(user_1)
    
    friends = parse_json(response.body)
    
    expect(friends[:friends].count).to eq(1)
    expect(friends[:friends].first[:id]).to eq(user_2.id)
  end

  it 'should delete friends' do
    user_1.friends << user_2
    delete api_v1_user_friend_path(user_1, user_2.id)
    
    expect(response).to be_successful
    
    deleted_friend = parse_json(response.body)
    
    expect(deleted_friend[:deleted]).to be(true)
    expect(user_1.friends.count).to eq(0)
    expect(user_2.friends.count).to eq(0)
  end
end
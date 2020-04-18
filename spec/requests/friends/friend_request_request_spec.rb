require 'rails_helper'

describe 'Friend Requests' do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user_1.id) }
  let(:token_2) { Doorkeeper::AccessToken.new(resource_owner_id: user_2.id) }
  
  before(:each) { allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token) }
  
  it 'should create friend request to another user' do
    expect(user_1.pending_friend_requests.count).to eq(0)
    post api_v1_user_friend_requests_path(user_1), params: { friend_id: user_2.id }
    
    expect(response).to be_successful
    friend_data = parse_json(response.body)
    
    expect(user_1.pending_friend_requests.count).to eq(1)
    expect(friend_data[:friend_request]).to eq('sent')
  end

  it 'should list all pending requests' do
    post api_v1_user_friend_requests_path(user_1), params: { friend_id: user_2.id }
    get api_v1_user_friend_requests_path(user_1)
    
    expect(response).to be_successful
    
    friend_requests = parse_json(response.body)
    
    expect(friend_requests[:friend_requests].count).to eq(1)
    expect(friend_requests[:friend_requests].first[:friend][:id]).to eq(user_2.id)
    expect(friend_requests[:friend_requests].first[:user][:id]).to eq(user_1.id)
  end

  it 'should accept friend requests' do
    post api_v1_user_friend_requests_path(user_1), params: { friend_id: user_2.id }
    expect(user_1.friends.count).to eq(0)
    pending_request = user_2.friend_requests.last
    
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token_2)
    
    put accept_api_v1_user_friend_request_path(user_2.id, pending_request.id)
    expect(response).to be_successful
  
    friend_requests = parse_json(response.body)
    
    expect(friend_requests[:friend_request]).to eq('accepted')
    expect(user_1.pending_friend_requests.count).to eq(0)
    expect(user_2.friend_requests.count).to eq(0)
    expect(user_1.friends.count).to eq(1)
    expect(user_2.friends.count).to eq(1)
    expect(user_1.friends.pluck(:id)).to include(user_2.id)
    expect(user_2.friends.pluck(:id)).to include(user_1.id)
  end

  it 'should decline friend requests' do
    post api_v1_user_friend_requests_path(user_1), params: { friend_id: user_2.id }
    expect(user_1.friends.count).to eq(0)
    pending_request = user_2.friend_requests.last

    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token_2)
    
    delete api_v1_user_friend_request_path(user_2, pending_request)
    
    expect(response).to be_successful
    friend_request = parse_json(response.body)
    
    expect(friend_request[:friend_request]).to eq('declined')
    expect(user_1.pending_friend_requests.count).to eq(0)
    expect(user_2.friend_requests.count).to eq(0)
  end
  
end
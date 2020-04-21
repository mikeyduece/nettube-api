require 'rails_helper'

describe 'Search' do
  let(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  
  before(:each) do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
  end
  
  it 'should search for videos' do
    post api_v1_search_videos_path, params: { term: 'Firefly' }
    
    expect(response).to be_successful
    
    videos = parse_json(response.body)
    
    expect(videos[:items].count).to eq(50)
    expect(videos[:previousPageToken]).to be_nil
  end

  it 'should fetch next page of videos' do
    post api_v1_search_videos_path, params: { term: 'Firefly' }
  
    expect(response).to be_successful
  
    videos = parse_json(response.body)
  
    expect(videos[:items].count).to eq(50)
    expect(videos[:previousPageToken]).not_to be_nil
  end
end
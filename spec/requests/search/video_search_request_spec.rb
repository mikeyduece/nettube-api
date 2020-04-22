require 'rails_helper'

describe 'Search' do
  let(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  
  before(:each) do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
  end
  
  it 'should search for videos' do
    use_cassette('initial_search') do
      post api_v1_search_videos_path, params: { term: 'Firefly' }
      
      expect(response).to be_successful
      
      videos = parse_json(response.body)
      
      expect(videos[:videos].count).to eq(50)
      expect(videos[:meta][:previous_page_token]).to be_nil
    end
  end
  
  it 'should fetch next page of videos' do
    use_cassette('next_page_search') do
      post api_v1_search_videos_path, params: { term: 'Firefly' }
      initial_search = parse_json(response.body)
      next_page_token = initial_search[:meta][:next_page_token]
      
      post api_v1_search_videos_path, params: { term: 'Firefly', next_page: next_page_token }
      
      expect(response).to be_successful
      
      videos = parse_json(response.body)
      
      expect(videos[:videos].count).to eq(50)
      expect(videos[:meta][:previous_page_token]).not_to be_nil
    end
  end
end
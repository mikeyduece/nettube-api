require 'rails_helper'

describe 'Youtube Client' do
  let(:client) { Youtube::Client.new }
  
  it 'should exist' do
    expect(client).to be_a(Youtube::Client)
  end
  
  it 'should search videos' do
    use_cassette('video_search_1') do
      videos = client.search(term: 'Firefly')
      
      expect(videos[:items].count).not_to be_zero
    end
    
  end
  
  it 'should search other videos' do
    use_cassette('video_search_2') do
      videos = client.search(term: 'HGTV')

      expect(videos[:items].count).not_to be_zero
    end
  end
end
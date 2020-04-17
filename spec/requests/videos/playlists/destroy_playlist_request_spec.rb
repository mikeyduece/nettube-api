require 'rails_helper'

describe 'Destroy Playists' do
  let!(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  
  before(:each) do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
  end
  
  context 'Remove videos from playlist' do
    it 'should only allow owner to remove videos' do
    
    end
    
  end
  
  context 'Delete Playlist' do
    it 'should only allow owner to delete playlist' do
    
    end
    
  end
  
end
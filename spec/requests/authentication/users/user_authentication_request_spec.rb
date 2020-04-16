require 'rails_helper'

describe 'User Authentication' do
  let! (:params) { {
    "user": {
      "first_name": "Rick",
      "last_name": "Astley",
      "email": "rick.roll@gmail.com",
      "password": "password"
    }
  } }
  
  let!(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  
  it 'should create a User' do
    post '/api/v1/users', params: params
    
    expect(response).to be_successful
    
    user_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(user_data[:user][:first_name]).to eq('Rick')
    expect(User.last.first_name).to eq(params[:user][:first_name])
  end
  
  xit 'should log a user in' do
    post '/api/v1/users', params: params
    post '/api/v1/oauth/tokens', params: { email: User.last.email, password: User.last.password }
    
    expect(response).to be_successful
  end
  
  xit 'should show users profile information if logged in' do
    allow_any_instance_of(ApiController).to receive(:doorkeeper_token).and_return(token)
    
    get '/api/v1/users/me'
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    user_json = JSON.parse(response.body, symbolize_names: true)
    expect(user_json[:user][:id]).to eq(user.id)
    expect(user_json[:user][:first_name]).to eq(user.first_name)
    expect(user_json[:user][:last_name]).to eq(user.last_name)
  end
  
  it 'should log a user out' do
  
  end
  
  it 'should show an error if not logged in' do
  end
end
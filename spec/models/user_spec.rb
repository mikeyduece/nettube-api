require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  
  context :associations do
    it { should have_many(:access_tokens) }
    it { should have_many(:access_grants) }
    it { should have_many(:favorites) }
  end
  
  context :validations do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
end

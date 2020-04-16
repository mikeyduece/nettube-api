require 'rails_helper'

RSpec.describe Favorite, type: :model do
  subject { build(:favorite) }
  
  context :associations do
    it { should belong_to(:user) }
    it { should belong_to(:video) }
  end
  
  context :validations do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:video_id) }
    it { should validate_uniqueness_of(:video_id).scoped_to(:user_id) }
  end
end

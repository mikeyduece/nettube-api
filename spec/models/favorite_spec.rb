require 'rails_helper'

RSpec.describe Favorite, type: :model do
  subject { build(:favorite) }
  
  context :associations do
    it { should belong_to(:user) }
    it { should belong_to(:target) }
  end
  
  context :validations do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:target) }
    it { should validate_uniqueness_of(:user_id).scoped_to(%i[target_id target_type]) }
  end
end

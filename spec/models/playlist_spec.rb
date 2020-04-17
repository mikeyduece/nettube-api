require 'rails_helper'

RSpec.describe Playlist, type: :model do
  subject { create(:playlist) }
  
  context :associations do
    it { should belong_to(:video) }
    it { should belong_to(:user) }
    # TODO: Add check for favorited_by_users relationship
  end
  
  context :validations do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(%i[user_id video_id]) }
    it { should validate_numericality_of(:number_of_favorites).is_greater_than_or_equal_to(0) }
  end
end

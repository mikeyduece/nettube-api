require 'rails_helper'

RSpec.describe Video, type: :model do
  subject { build(:video) }
  
  context :associations do
    it { should have_many(:favorited_by_users).through(:favorites) }
    it { should have_many(:playlist_videos) }
    it { should have_many(:playlists).through(:playlist_videos) }
  end
  
  context :validations do
    it { should validate_numericality_of(:number_of_favorites).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:youtube_id) }
  end

end

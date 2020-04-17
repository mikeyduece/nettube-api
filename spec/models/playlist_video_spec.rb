require 'rails_helper'

RSpec.describe PlaylistVideo, type: :model do
  subject { create(:playlist_video) }
  
  context :associations do
    it { should belong_to(:video) }
    it { should belong_to(:playlist) }
  end
  
  context :validations do
    it { should validate_presence_of(:video_id) }
    it { should validate_presence_of(:playlist_id) }
    it { should validate_uniqueness_of(:playlist_id).scoped_to(:video_id) }
  end
end

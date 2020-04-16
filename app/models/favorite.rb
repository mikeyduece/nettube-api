class Favorite < ApplicationRecord
  belongs_to :user, inverse_of: :favorites
  belongs_to :video, inverse_of: :favorites
  
  validates :user_id, :video_id, presence: true
  validates :video_id, uniqueness: { scope: :user_id }
  
  # TODO: Create callbacks to increment and decrement video number of favorites
  
end
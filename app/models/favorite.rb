class Favorite < ApplicationRecord
  belongs_to :user, inverse_of: :favorites
  belongs_to :video, inverse_of: :favorites
  
  validates :user_id, :video_id, presence: true
  validates :video_id, uniqueness: { scope: :user_id }
  
  before_commit :increment_number_of_favorites, on: :create
  before_destroy :decrement_number_of_favorites
  
  private
  
  def increment_number_of_favorites
    new_total = video.number_of_favorites + 1
    
    video.update(number_of_favorites: new_total)
  end
  
  def decrement_number_of_favorites
    new_total = video.number_of_favorites - 1
    
    video.update(number_of_favorites: new_total)
  end
  
end
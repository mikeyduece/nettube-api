class Playlist < ApplicationRecord
  belongs_to :user
  belongs_to :video
  
  validates :name, :user_id, :video_id, presence: true
  validates :name, uniqueness: { scope: %i[user_id video_id] }
  validates :number_of_favorites, numericality: { greater_than_or_equal_to: 0 }
end

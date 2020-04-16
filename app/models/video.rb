class Video < ApplicationRecord
  has_many :favorites, inverse_of: :video
  has_many :users, through: :favorites
  
  validates :number_of_favorites, numericality: { greater_than_or_equal_to: 0 }
  validates :youtube_id, presence: true
end

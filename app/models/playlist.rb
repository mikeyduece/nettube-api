class Playlist < ApplicationRecord
  belongs_to :user, inverse_of: :playlists
  
  has_many :playlist_videos, inverse_of: :playlist, dependent: :destroy
  has_many :videos, through: :playlist_videos
  
  validates :name, :user_id, presence: true
  validates :name, uniqueness: { scope: %i[user_id], case_sensitive: false }
  validates :number_of_favorites, numericality: { greater_than_or_equal_to: 0 }
end

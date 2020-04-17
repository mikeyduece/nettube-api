class Video < ApplicationRecord
  has_many :favorites, as: :target, inverse_of: :target
  has_many :users, through: :favorites
  
  has_many :playlist_videos, inverse_of: :video, dependent: :destroy
  has_many :playlists, through: :playlist_videos
  
  validates :number_of_favorites, numericality: { greater_than_or_equal_to: 0 }
  validates :youtube_id, presence: true
  
  def blueprint
    ::Videos::OverviewBlueprint
  end
end

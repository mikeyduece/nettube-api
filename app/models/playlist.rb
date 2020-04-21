class Playlist < ApplicationRecord
  default_scope { order(updated_at: :desc) }
  include Favoritable
  
  belongs_to :user, inverse_of: :playlists
  
  has_many :playlist_videos, inverse_of: :playlist, dependent: :destroy
  has_many :videos, through: :playlist_videos
  
  validates :name, :user_id, presence: true
  validates :name, uniqueness: { scope: %i[user_id], case_sensitive: false }
  validates :number_of_favorites, numericality: { greater_than_or_equal_to: 0 }
  
  enum view_status: %i[closed open]
  
  scope :top_ten, -> { order('COUNT(number_of_favorites) DESC').group(:id).limit(10) }
  
  after_commit :broadcast_to_subscribers
  
  def blueprint
    ::Users::Playlists::OverviewBlueprint
  end
  
  private
  
  def broadcast_to_subscribers
    PlaylistRelayWorker.perform_async(id)
  end
end

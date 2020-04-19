class User < ApplicationRecord
  include Authentication
  include Favoritable
  include Friendable
  
  has_many :playlists, inverse_of: :user
  has_many :open_playlists, -> { where(view_status: Playlist.view_statuses[:open])}, class_name: 'Playlist'
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  
  favoritable :videos, :playlists
  
  def scoped_playlists(api_user:, limit:, offset:)
    return playlists.open | playlists.closed if api_user.eql?(self) || friends.exists?(id: api_user.id)
    
    playlists.closed
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end

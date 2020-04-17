class User < ApplicationRecord
  include Authentication
  
  has_many :favorites, inverse_of: :user
  has_many :favorite_videos, through: :favorites, source: :target, source_type: 'Video'
  has_many :playlists, inverse_of: :user
  
  has_many :friends
  has_many :pending_friend_requests, class_name: 'FriendRequest', source: :user
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  
  def name
    "#{first_name} #{last_name}"
  end
end

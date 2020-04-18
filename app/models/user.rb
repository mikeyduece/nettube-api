class User < ApplicationRecord
  include Authentication
  include Favoritable
  include Friendable
  
  has_many :playlists, inverse_of: :user
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  
  favoritable :videos, :playlists
  
  def name
    "#{first_name} #{last_name}"
  end
end

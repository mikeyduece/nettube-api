class User < ApplicationRecord
  include Authentication
  
  has_many :favorites, inverse_of: :user
  has_many :favorite_videos, through: :favorites, source: :video
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end

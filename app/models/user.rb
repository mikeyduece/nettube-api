class User < ApplicationRecord
  include Authentication
  
  has_many :favorites, inverse_of: :user
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end

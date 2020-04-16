class User < ApplicationRecord
  include Authentication
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
end

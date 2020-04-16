module Authentication
  extend ActiveSupport::Concern
  
  included do
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    
    has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
             dependent: :delete_all,
             as: :resource_owner
    
    has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
             dependent: :delete_all,
             as: :resource_owner
  
  end
end
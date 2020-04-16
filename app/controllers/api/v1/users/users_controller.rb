module Api
  module V1
    module Users
      class UsersController < UsersBaseController
        skip_before_action :doorkeeper_authorize!, only: :create
        
        def create
        
        end
        
      end
    end
  end
end

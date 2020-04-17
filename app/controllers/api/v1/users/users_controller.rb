module Api
  module V1
    module Users
      class UsersController < UsersBaseController
        skip_before_action :doorkeeper_authorize!, :set_user!, only: :create
        
        def create
          user = User.new(user_params)
          return success_response(201, user: serialized_resource(user, ::Users::OverviewBlueprint, view: :extended)) if user.save
          
          error_reponse(user.errors.full_messages.first, 404)
        end
        
        private
        
        def user_params
          params.require(:user).permit(:first_name, :last_name, :email, :password)
        end
        
      end
    end
  end
end

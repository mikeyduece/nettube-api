module Api
  module V1
    module Users
      class UsersBaseController < ApiController
        before_action :set_user!
  
        def set_user!
          if (params[:user_id].eql?('me') || params[:id].eql?('me')) && current_api_user
            @user = current_api_user
          else
            @user = User.find_by(id: params[:user_id] || params[:id])
      
            if @user.blank?
              error_response(t('api.defaults.not_found', 404))
            end
          end
        end
      end
    end
  end
end
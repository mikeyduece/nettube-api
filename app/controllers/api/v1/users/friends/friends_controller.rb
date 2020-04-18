module Api
  module V1
    module Users
      module Friends
        class FriendsController < UsersBaseController
          
          def index
            user_view = @user.eql?(current_api_user) ? :extended : :normal
            success_response(200, friends: serialized_resource(@user.friends, ::Users::OverviewBlueprint, view: user_view))
          end
          
          def destroy
            friend = current_api_user.friendships.find_by(friend_id: params[:id])
            success_response(204, deleted: true) if friend&.destroy
          end
          
        end
      end
    end
  end
end
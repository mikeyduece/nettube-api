module Api
  module V1
    module Users
      module FriendRequests
        class FriendRequestsController < UsersBaseController
          before_action :set_friend_request!, only: %i[accept destroy]
          
          def index
            friend_requests = current_api_user.pending_friend_requests
            success_response(200, friend_requests: serialized_resource(friend_requests, ::Users::FriendRequests::OverviewBlueprint))
          end
          
          def create
            friend_request = current_api_user.pending_friend_requests.build(friend_id: params[:friend_id])
            return success_response(201, friend_request: :sent) if friend_request.save
            
            error = friend_request.errors.full_messages.first
            error_response(error, 500)
          end
          
          def destroy
            return success_response(204, friend_request: :declined) if @friend_request&.destroy
            
            handle_error
          end
          
          def accept
            return success_response(203, friend_request: :accepted) if @friend_request&.accept

            handle_error
          end
          
          private
          
          def set_friend_request!
            @friend_request = current_api_user.friend_requests.find_by(id: params[:id])
          end
          
          def handle_error
            error = @friend_request.errors.full_messages.first
            error_response(error, 500)
          end
          
        end
      end
    end
  end
end
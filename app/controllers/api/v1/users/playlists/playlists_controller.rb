module Api
  module V1
    module Users
      module Playlists
        class PlaylistsController < UsersBaseController
          
          def index
            ::Videos::Playlists::Index.call(@user, api_user: current_api_user, limit: limit, offset: offset) do |success, failure|
              success.call do |resource|
                success_response(200, playlists: serialized_resource(resource, ::Users::Playlists::OverviewBlueprint))
              end
              
              failure.call(&method(:error_response))
            end
          end
          
          def create
            ::Videos::Playlists::Create.call(current_api_user, playlist_params) do |success, failure|
              success.call do |resource|
                success_response(201, playlist: serialized_resource(resource, ::Users::Playlists::OverviewBlueprint))
              end
              
              failure.call(&method(:error_response))
            end
          end
          
          private
          
          def playlist_params
            params.require(:playlist).permit(:id, :name, :user_id, video: {})
          end
          
        end
      end
    end
  end
end
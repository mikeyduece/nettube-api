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
          
          def toggle
            playlist_id = params[:playlist_id] || params[:id]
            ensure_user_owns(:playlists, playlist_id) do
              playlist = @user.playlists.find_by(id: playlist_id)
              
              playlist.open? ? playlist.closed! : playlist.open!
              
              success_response(202, view_status: playlist.view_status)
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
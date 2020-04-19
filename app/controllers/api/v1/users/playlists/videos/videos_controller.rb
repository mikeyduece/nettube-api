module Api
  module V1
    module Users
      module Playlists
        module Videos
          class VideosController < UsersBaseController
            
            def create
              ensure_user_owns(:playlists, params[:playlist_id]) do
                ::Videos::Playlists::Videos::Create.call(current_api_user, params) do |success, failure|
                  success.call do |resource|
                    success_response(201, playlist: serialized_resource(resource, ::Users::Playlists::OverviewBlueprint))
                  end
                  
                  failure.call(&method(:error_response))
                end
              end
              
            end
            
            def destroy
              ensure_user_owns(:playlists, params[:playlist_id]) do
                playlist = current_api_user.playlists.find_by(id: params[:playlist_id])
                video = playlist.videos.find_by(id: params[:video_id] || params[:id])
                
                if video.destroy
                  return success_response(204, playlist: serialized_resource(playlist, ::Users::Playlists::OverviewBlueprint))
                end
                
                error = video.errors.full_messages.first
                error_response(error, 500)
              end
            end
          
          end
        end
      end
    end
  end
end
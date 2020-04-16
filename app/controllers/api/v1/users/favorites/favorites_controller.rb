module Api
  module V1
    module Users
      module Favorites
        class FavoritesController < ApiController
          def create
            Videos::Favorites::Create.call(current_api_user, video_params) do |success, failure|
              success.call do |video|
                success_response(201, favorite: serialized_resource(video, video_blueprint))
              end
              
              failure.call(&method(:error_response))
            end
          end
          
          private
          
          def video_params
            params.require(:video).permit(:id, :youtube_id, :etag, :title, :description,
                                          :img_high, :img_default, :published_at)
          end
          
          def video_blueprint
            ::Videos::OverviewBlueprint
          end
          
        end
      end
    end
  end
end
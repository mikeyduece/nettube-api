module Api
  module V1
    module Users
      module Favorites
        class FavoritesController < UsersBaseController
          skip_before_action :set_user!, only: %i[create destroy]
          
          def create
            Videos::Favorites::Create.call(current_api_user, params) do |success, failure|
              success.call { success_response(201, favorited: true) }
              failure.call(&method(:error_response))
            end
          end
          
          def destroy
            favorite = current_api_user.favorites.find_by(id: params[:id])
            return success_response(204, favorite: { deleted: true }) if favorite.destroy
            
            error_response(favorite.full_messages.to_sentence.first, 500)
          end
          
          private
          
          def video_params
            params.require(:video).permit(:id, :youtube_id, :etag, :title, :description,
                                          :img_high, :img_default, :published_at)
          end
          
        end
      end
    end
  end
end
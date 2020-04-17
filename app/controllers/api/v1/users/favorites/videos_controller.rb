module Api
  module V1
    module Users
      module Favorites
        class VideosController < UsersBaseController
          before_action :set_user!
          
          def index
            favorites = @user.favorite_videos
            success_response(200, favorites: serialized_resource(favorites, ::Videos::OverviewBlueprint))
          end
          
        end
      end
    end
  end
end
module Api
  module V1
    module Users
      module Favorites
        class PlaylistsController < UsersBaseController
          before_action :set_user!
          
          def index
            playlists = current_api_user.favorite_playlists
            success_response(200, favorites: serialized_resource(playlists, ::Users::Playlists::OverviewBlueprint))
          end
        
        end
      end
    end
  end
end
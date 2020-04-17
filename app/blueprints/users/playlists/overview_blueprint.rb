module Users
  module Playlists
    class OverviewBlueprint < BaseBlueprint
      fields :name
      association :videos, blueprint: Videos::OverviewBlueprint
      association :user, blueprint: Users::OverviewBlueprint, view: :normal
      
    end
  end
end
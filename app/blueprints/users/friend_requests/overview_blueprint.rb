module Users
  module FriendRequests
    class OverviewBlueprint < BaseBlueprint
      association :user, blueprint: Users::OverviewBlueprint, view: :normal
      association :friend, blueprint: Users::OverviewBlueprint, view: :normal
      
    end
  end
end
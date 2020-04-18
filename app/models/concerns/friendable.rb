module Friendable
  extend ActiveSupport::Concern
  
  included do
    has_many :pending_friend_requests, class_name: 'FriendRequest'
    has_many :friend_requests, source: :friend, foreign_key: :friend_id
    has_many :friendships
    has_many :friends, through: :friendships
  end
end
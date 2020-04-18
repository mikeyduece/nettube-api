class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  def accept
    user.friends << friend
    friend.friends << user
    destroy
  end
end

class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: :friend_id

  def create_inverse_relationship
    friend.friends.create(friend: user)
  end

  def destroy_inverse_relationship
    friendship = friend.friends.find_by(friend: user)
    friendship.destroy if friendship
  end
end

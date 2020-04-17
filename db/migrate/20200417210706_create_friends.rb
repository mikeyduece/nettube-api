class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :friend_id, foreign_key: true, index: true, null: false
      
      t.timestamps
    end
  end
end

class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :name, index: true
      t.integer :number_of_favorites, default: 0, index: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :playlists, %i[user_id name], unique: true
  end
end

class AddViewStatusToPlaylists < ActiveRecord::Migration[6.0]
  def change
    add_column :playlists, :view_status, :integer, default: 0
    add_index :playlists, :view_status
  end
end

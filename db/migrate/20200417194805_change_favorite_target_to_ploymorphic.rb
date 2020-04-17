class ChangeFavoriteTargetToPloymorphic < ActiveRecord::Migration[6.0]
  def change
    remove_reference :favorites, :video if column_exists?(:favorites, :video_id)
    remove_index :favorites, name: :index_favorites_on_user_id_and_video_id if index_exists?(:favorites, name: :index_favorites_on_user_id_and_video_id)
    
    change_table :favorites do |t|
      t.references :target, polymorphic: true, null: false
    end
    
    add_index :favorites, %i[user_id target_id target_type], unique: true
    
  end
end

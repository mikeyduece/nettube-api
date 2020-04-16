class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :etag
      t.string :youtube_id, index: true
      t.string :img_high
      t.string :img_default
      t.string :title, index: true
      t.string :description
      t.datetime :published_at
      t.integer :number_of_favorites, default: 0, index: true
    
      t.timestamps
    end
  end
end

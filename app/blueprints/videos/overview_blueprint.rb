class Videos::OverviewBlueprint < BaseBlueprint
  fields :youtube_id, :etag, :title, :description, :img_high, :img_default,
  :published_at, :number_of_favorites
end
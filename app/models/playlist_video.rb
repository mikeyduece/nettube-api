class PlaylistVideo < ApplicationRecord
  belongs_to :video, inverse_of: :playlist_videos
  belongs_to :playlist, inverse_of: :playlist_videos
  
  validates :video_id, :playlist_id, presence:  true
  validates :playlist_id, uniqueness: {scope: :video_id}
end

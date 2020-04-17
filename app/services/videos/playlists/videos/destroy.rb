module Videos
  module Playlists
    module Videos
      class Destroy < BaseVideoService
      
        def call(&block)
          find_playlist!
          @playlist_video.destroy!
          
          yield(Success.new(@playlist), NoTrigger)
        rescue StandardError => e
          yield(NoTrigger, Failure.new(e.message, 500))
        end
        
        private
        
        def playlist_video
          @playlist_video ||= @playlist.playlist_videos.find_by(video_id: params[:video_id] || params[:id])
        end
        
      end
    end
  end
end

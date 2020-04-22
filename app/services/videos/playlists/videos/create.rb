module Videos
  module Playlists
    module Videos
      class Create < BaseVideoService
        
        def call(&block)
          find_playlist!
          add_video_to_playlist!
          
          yield(Success.new(@playlist), NoTrigger)
        rescue StandardError => e
          yield(NoTrigger, Failure.new(e.message, 500))
        end
        
        private

        def add_video_to_playlist!
          video = find_or_create_video
          return unless @playlist && video
  
          @playlist.playlist_videos.create(video: video)
        end
        
      end
    end
  end
end
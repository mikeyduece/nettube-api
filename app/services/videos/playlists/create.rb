module Videos
  module Playlists
    class Create < BaseVideoService
      def call(&block)
        create_playlist!
        add_video
        
        yield(Success.new(@playlist), NoTrigger)
  
      rescue StandardError => e
        yield(NoTrigger, Failure.new(e.message, 500))
      end
      
      private
      
      def create_playlist!
        @playlist ||= user.playlists.create(name: params[:name])
      end
      
      def add_video
        video = create_video
        
        @playlist.playlist_videos.create(video: video)
      end
      
    end
  end
end

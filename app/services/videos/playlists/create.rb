module Videos
  module Playlists
    class Create < BaseVideoService
      def call(&block)
        create_playlist!
        add_video
        
        yield(Success.new(@playlist), NoTrigger)
  
      rescue StandardError => e
        message = @playlist.errors.full_messages.first
        yield(NoTrigger, Failure.new(message, 500))
      end
      
      private
      
      def create_playlist!
        @playlist ||= user.playlists.build(name: params[:name])
        @playlist.save!
      end
      
      def add_video
        video = create_video
        return unless video
        
        @playlist.playlist_videos.create(video: video)
      end
      
    end
  end
end

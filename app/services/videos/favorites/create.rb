module Videos
  module Favorites
    class Create < BaseVideoService
      
      def call(&block)
        favorited_video = create_favorite
        yield(Success.new(favorited_video), NoTrigger)
      
      rescue StandardError => e
        yield(NoTrigger, Failure.new(e.message, 500))
      end
      
      private
      
      def create_favorite
        video = create_video
        user.favorites.create(video: video)
        
        video
      end
      
      def update_etag(etag)
        @video.update_attributes(etag: etag)
      end
    
    end
  end
end
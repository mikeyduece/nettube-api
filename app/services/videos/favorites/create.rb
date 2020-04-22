module Videos
  module Favorites
    class Create < BaseVideoService
      
      def call(&block)
        favorite = create_favorite
        yield(Success.new(favorite), NoTrigger)
        
      rescue StandardError => e
        yield(NoTrigger, Failure.new(e.message, 500))
      end
      
      private
      
      def create_favorite
        target = find_or_create_target
        user.favorites.create(target: target)
        
        target
      end

      def find_or_create_target
        return find_or_create_video if params[:target_type].eql?('Video')
        
        
        find_playlist!
      end
      
      def find_playlist!
        Playlist.find_by(id: params[:target_id])
      end
      
      def update_etag(etag)
        @video.update_attributes(etag: etag)
      end
    
    end
  end
end
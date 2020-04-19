module Videos
  module Playlists
    class Index < BaseVideoService
      def call(&block)
        yield(Success.new(playlists), NoTrigger)
      rescue StandardError => e
        message = @playlist.errors.full_messages.first
        yield(NoTrigger, Failure.new(message, 500))
      end
      
      private
      
      def playlists
        return [] if offset >= user.playlists.length
        
        scoped_playlists
      end
      
      def scoped_playlists
        api_user = params[:api_user]
        return all_playlists_for_user if user.eql?(api_user) || user.friends.exists?(id: api_user.id)
        
        user.playlists.open.limit(limit).offset(offset)
      end
      
      def all_playlists_for_user
        lists = user.playlists.open | user.playlists.closed
        lists.drop(offset).first(limit)
      end
    
    end
  end
end

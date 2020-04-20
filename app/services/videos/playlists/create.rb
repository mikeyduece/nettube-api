module Videos
  module Playlists
    class Create < BaseVideoService
      def call(&block)
        create_playlist!
        yield(Success.new(@playlist), NoTrigger)
  
      rescue StandardError => e
        message = @playlist.errors.full_messages.first
        yield(NoTrigger, Failure.new(message, 500))
      end
      
      private
      
      def create_playlist!
        @playlist ||= user.playlists.find_or_create_by(name: params[:name])
        broadcast_for_channel(:playlists_channel, playlist_blueprint, @playlist)
      end
      
    end
  end
end

module Search
  module Videos
    class Create < BaseService
      
      def call(&block)
        items = search!
        yield(Success.new({meta: meta(items), videos: videos(items[:items])}), NoTrigger)
      rescue StandardError => e
        yield(NoTrigger, Failure.new(e.message, 500))
      end
      
      private
      
      def meta(items)
        {
          next_page_token: items[:nextPageToken],
          previous_page_token: items[:prevPageToken],
          total_count: items[:pageInfo][:totalResults],
          per_page: items[:pageInfo][:resultsPerPage]
        }
      end
      
      def videos(videos)
        videos.map { |youtube_video| VideoFacade.new(youtube_video) }
      end
      
      def client
        @client ||= Youtube::Client.new
      end
      
      def search!
        client.search(term: params[:term], next_page: next_page, previous_page: previous_page)
      end
      
      def next_page
        params[:next_page]
      end
      
      def previous_page
        params[:previous_page]
      end
    
    end
  end
end
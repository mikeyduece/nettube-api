class Youtube::Client
  
  def search(term:, next_page: false, previous_page: false)
    query = "?q=#{term}"
    videos = get_url(query)
    videos = search_with_pagination(videos, query, previous_page) if next_page
    videos
  end

  private
  
  def set_page_tokens(video_return)
    return video_return[:nextPageToken], video_return[:previousPageToken]
  end
  
  def search_with_pagination(videos, query, previous_page)
    next_page_token, previous_page_token = set_page_tokens(videos)
    return get_url(query + "&pageToken=#{previous_page_token}") if previous_page
    
    get_url(query + "&pageToken=#{next_page_token}")
  end
  
  def get_url(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def connection
    @connection ||= Faraday.new(url: "https://www.googleapis.com/youtube/v3/search") do |faraday|
      faraday.params["part"] = 'snippet'
      faraday.params["key"] = "#{ENV['YOUTUBE_API_KEY']}"
      faraday.params["maxResults"] = '50'
      
      faraday.adapter Faraday.default_adapter
    end
  end
end
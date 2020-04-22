class Youtube::Client
  
  def search(term:, next_page: nil, previous_page: nil)
    query = "?q=#{term}"
    videos = initial_search(query) unless next_page || previous_page
    videos = search_with_pagination(query, next_page, previous_page) if next_page || previous_page
    
    videos
  end

  private
  
  def search_with_pagination(query, next_page, previous_page)
    videos = paginated_search(query, previous_page) if previous_page
    videos = paginated_search(query, next_page) if next_page
    
    videos
  end
  
  def paginated_search(query, token)
    get_url(query + "&pageToken=#{token}")
  end
  
  def initial_search(query)
    videos = get_url(query)
    videos
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
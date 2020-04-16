class Youtube::Client
  
  def search(term:)
    get_url("?q=#{term}")
  end

  private

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
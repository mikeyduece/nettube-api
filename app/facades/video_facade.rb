class VideoFacade
  attr_reader :id, :youtube_id, :etag, :title, :description, :img_high, :img_default,
              :published_at, :number_of_favorites
  
  def initialize(params)
    @id = nil
    @youtube_id = params[:id][:videoId]
    @etag = params[:etag]
    @title = params[:snippet][:title]
    @description = params[:snippet][:description]
    @img_high = params[:snippet][:thumbnails][:high][:url]
    @img_default = params[:snippet][:thumbnails][:default][:url]
    @published_at = DateTime.parse(params[:snippet][:publishedAt]).to_i
  end
  
  def number_of_favorites
    video = Video.find_by(youtube_id: youtube_id)
    return 0 unless video
    
    @number_of_favorites ||= video.number_of_favorites
  end
end
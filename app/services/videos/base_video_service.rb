class Videos::BaseVideoService
  
  def self.call(user, params={}, &block)
    new(user, params).call(&block)
  end

  def initialize(user, params)
    @user = user
    @params = params
  end
  private_class_method :new

  def call(&block)
    raise NotImplementedError
  end
  
  private
  
  attr_reader :user, :params
  
  def limit
    params[:limit]
  end
  
  def offset
    params[:offset]
  end

  def find_playlist!
    @playlist ||= user.playlists.find_by(id: params[:playlist_id] || params[:id])
  end
  
  def find_or_create_video
    video_params = params[:video] || params
    video = Video.find_by(youtube_id: video_params[:youtube_id])
    
    if video && video.etag != video_params[:etag]
      video.update_attributes(etag: video_params[:etag])
    elsif video.nil?
      video = Video.create(etag:         video_params[:etag],
                           youtube_id:       video_params[:youtube_id],
                           img_high:     video_params[:img_high],
                           img_default:  video_params[:image_default],
                           title:        video_params[:title],
                           published_at: video_params[:published_at],
                           description:  video_params[:description]
      )
    end
    video
  end

end
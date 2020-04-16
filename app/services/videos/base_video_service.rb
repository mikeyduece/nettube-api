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
  
  def create_video
    video = Video.find_by(youtube_id: params[:youtube_id])
    
    if video && video.etag != params[:etag]
      video.update_attributes(etag: params[:etag])
    elsif video.nil?
      video = Video.create(etag:         params[:etag],
                           youtube_id:       params[:youtube_id],
                           img_high:     params[:img_high],
                           img_default:  params[:image_default],
                           title:        params[:title],
                           published_at: params[:published_at],
                           description:  params[:description]
      )
    end
    video
  end
  
end
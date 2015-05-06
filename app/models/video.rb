class Video < ActiveRecord::Base

  YT_video_url_FORMAT = /\A^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*\z/i

  before_create do
    video_id = video_url.match(YT_video_url_FORMAT)

    self.video_id = video_id[2] if video_id && video_id[2]

    if self.video_id.to_s.length != 11
      self.errors.add(:video_url, 'недействительна.')
      false
    elsif Video.where(video_id: self.video_id).any?
      self.errors.add(:video_url, 'уже добавлена.')
      false
    else
      get_additional_info
    end
  end

  validates :video_url, presence: true, 
            format: YT_video_url_FORMAT, 
            uniqueness: { case_sensitive: false } 

  private
  
  def get_additional_info
    begin
      client = YouTubeIt::OAuth2Client.new(dev_key: ENV['YT_DEV'])
      video = client.video_by(video_id)
      self.title = video.title
      self.duration = parse_duration(video.duration)
      self.author = video.author.name
      self.likes = video.rating.likes
      self.dislikes = video.rating.dislikes
    rescue
      self.title = '' ; self.duration = '00:00:00' ; self.author = '' ; self.likes = 0 ; self.dislikes = 0
    end
  end

  def parse_duration(d)
      hr = (d / 3600).floor
      min = ((d - (hr * 3600)) / 60).floor
      sec = (d - (hr * 3600) - (min * 60)).floor
      
      hr = '0' + hr.to_s if hr.to_i < 10
      min = '0' + min.to_s if min.to_i < 10
      sec = '0' + sec.to_s if sec.to_i < 10
      
      hr.to_s + ':' + min.to_s + ':' + sec.to_s
    end
  end

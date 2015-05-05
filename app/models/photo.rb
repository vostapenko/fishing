class Photo < ActiveRecord::Base

  validates :photo_id, :photo_url, :title, :description, presence: true

end

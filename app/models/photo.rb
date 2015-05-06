class Photo < ActiveRecord::Base

  validates :photo_id, :description, presence: true
  validates :photo_url, presence:  true, uniqueness: { case_sensitive: false }
end

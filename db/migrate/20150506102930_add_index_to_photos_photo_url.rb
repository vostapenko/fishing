class AddIndexToPhotosPhotoUrl < ActiveRecord::Migration
  def change
    add_index :photos, :photo_url, unique: true
  end
end

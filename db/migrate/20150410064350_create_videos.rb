class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :video_id
      t.string :video_url
      t.string :author
      t.string :title
      t.string :duration
      t.integer :likes
      t.integer :dislikes

      t.timestamps null: false
    end
  end
end

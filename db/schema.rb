# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150513124651) do

  create_table "photos", force: :cascade do |t|
    t.string   "photo_id",    limit: 255
    t.string   "photo_url",   limit: 255
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "photos", ["photo_url"], name: "index_photos_on_photo_url", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "password_digest",   limit: 255
    t.string   "remember_digest",   limit: 255
    t.boolean  "admin",             limit: 1,   default: false
    t.string   "activation_digest", limit: 255
    t.boolean  "activated",         limit: 1,   default: false
    t.datetime "activated_at"
    t.string   "reset_digest",      limit: 255
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "video_id",   limit: 255
    t.string   "video_url",  limit: 255
    t.string   "author",     limit: 255
    t.string   "title",      limit: 255
    t.string   "duration",   limit: 255
    t.integer  "likes",      limit: 4
    t.integer  "dislikes",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "videos", ["video_url"], name: "index_videos_on_video_url", unique: true, using: :btree

end

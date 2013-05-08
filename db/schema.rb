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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130425220732) do

  create_table "categories", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "item_id",    :null => false
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "following_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "fuman_tags", :force => true do |t|
    t.integer  "fuman_id",   :null => false
    t.integer  "user_id",    :null => false
    t.integer  "item_id",    :null => false
    t.integer  "tag_id",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fumans", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.integer  "status",      :default => 1
    t.integer  "category_id"
    t.text     "tag_ids"
    t.integer  "item_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "service_code"
    t.string   "product_id"
    t.string   "url",          :limit => 1024
    t.string   "preview_url",  :limit => 1024
    t.string   "title",        :limit => 512
    t.text     "description"
    t.datetime "release_date"
    t.string   "image_s",      :limit => 1024
    t.string   "image_m",      :limit => 1024
    t.string   "image_l",      :limit => 1024
    t.integer  "is_adult"
    t.integer  "price"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "old_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "tag_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                               :null => false
    t.string   "crypted_password"
    t.string   "icon_name",              :limit => 1024
    t.string   "email"
    t.integer  "sex"
    t.datetime "birthday"
    t.text     "message"
    t.string   "twitter_use"
    t.integer  "facebook_use"
    t.string   "provider"
    t.string   "uid"
    t.string   "reset_hash"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "icon_name_file_name"
    t.string   "icon_name_content_type"
    t.integer  "icon_name_file_size"
    t.datetime "icon_name_updated_at"
  end

end

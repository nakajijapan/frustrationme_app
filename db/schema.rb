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

ActiveRecord::Schema.define(:version => 20120914012927) do

  create_table "categories", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "frendships", :force => true do |t|
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

  create_table "fumen", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.datetime "date"
    t.string   "title"
    t.integer  "price",       :default => 0
    t.text     "content"
    t.integer  "priority",    :default => 2
    t.integer  "status",      :default => 1
    t.text     "tag_ids"
    t.integer  "category_id"
    t.integer  "item_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "type"
    t.integer  "product_id"
    t.string   "url",         :limit => 1024
    t.string   "url_media",   :limit => 1024
    t.text     "description"
    t.datetime "date"
    t.string   "image_s",     :limit => 1024
    t.string   "image_m",     :limit => 1024
    t.string   "image_l",     :limit => 1024
    t.integer  "is_adult"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "tag_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "crypted_password", :null => false
    t.string   "icon_name"
    t.string   "email",            :null => false
    t.integer  "sex"
    t.datetime "birthday"
    t.integer  "pref"
    t.text     "message"
    t.string   "twitter_id"
    t.text     "twitter_token"
    t.integer  "twitter_notice"
    t.string   "facebook_id"
    t.text     "facebook_token"
    t.integer  "facebook_notice"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end

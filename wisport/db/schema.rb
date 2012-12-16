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

ActiveRecord::Schema.define(:version => 20121216154742) do

  create_table "do_exercises", :force => true do |t|
    t.integer  "user_id"
    t.string   "visibility"
    t.float    "distance"
    t.integer  "reps"
    t.integer  "hours"
    t.integer  "minutes"
    t.integer  "seconds"
    t.integer  "exercise_id"
    t.integer  "do_session_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "do_exercises", ["do_session_id"], :name => "index_do_exercises_on_do_session_id"
  add_index "do_exercises", ["exercise_id"], :name => "index_do_exercises_on_exercise_id"
  add_index "do_exercises", ["user_id"], :name => "index_do_exercises_on_user_id"

  create_table "do_sessions", :force => true do |t|
    t.integer  "user_id"
    t.string   "visibility"
    t.text     "remarks"
    t.integer  "trainings_session_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "do_sessions", ["trainings_session_id"], :name => "index_do_sessions_on_trainings_session_id"
  add_index "do_sessions", ["user_id"], :name => "index_do_sessions_on_user_id"

  create_table "events", :force => true do |t|
    t.integer  "trainings_session_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "all_day",              :default => true
    t.string   "color"
    t.boolean  "published",            :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "exercises", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "visibility"
    t.string   "type"
    t.float    "distance",       :default => 0.0
    t.integer  "reps",           :default => 0
    t.integer  "hours",          :default => 0
    t.integer  "minutes",        :default => 0
    t.integer  "seconds",        :default => 0
    t.integer  "owner_id"
    t.integer  "information_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "exercises_trainings_sessions", :force => true do |t|
    t.integer "exercise_id",          :null => false
    t.integer "trainings_session_id", :null => false
  end

  create_table "friends", :force => true do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "images", :force => true do |t|
    t.string   "original"
    t.string   "imagur_page"
    t.string   "delete_page"
    t.string   "small_square"
    t.string   "large_thumbnail"
    t.string   "delete_hash"
    t.integer  "information_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "information", :force => true do |t|
    t.string   "media"
    t.text     "description"
    t.integer  "exercise_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "likable_id"
    t.string   "likable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"

  create_table "trainings_sessions", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "visibility"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_login_services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "login"
    t.string   "acces_token"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "image"
    t.string   "refresh_token"
    t.datetime "token_expiration"
    t.string   "profile_link"
  end

  add_index "user_login_services", ["user_id"], :name => "index_user_login_services_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end

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

ActiveRecord::Schema.define(:version => 20121102150808) do

  create_table "exercises", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "type"
    t.float    "distance",       :default => 0.0
    t.integer  "reps",           :default => 0
    t.integer  "hours",          :default => 0
    t.integer  "minutes",        :default => 0
    t.integer  "seconds",        :default => 0
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

  create_table "information", :force => true do |t|
    t.string   "media"
    t.text     "description"
    t.integer  "exercise_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tests", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "trainings_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

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

ActiveRecord::Schema.define(:version => 20111213215925) do

  create_table "assets", :force => true do |t|
    t.string   "file"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  create_table "assignations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignations", ["course_id"], :name => "index_assignations_on_course_id"
  add_index "assignations", ["user_id"], :name => "index_assignations_on_user_id"

  create_table "assignments", :force => true do |t|
    t.integer  "course_id"
    t.string   "name"
    t.text     "description"
    t.integer  "value"
    t.integer  "period"
    t.datetime "due_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "finish_date"
    t.boolean  "public"
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "network_id"
    t.string   "logo_file"
  end

  add_index "courses", ["network_id"], :name => "index_courses_on_network_id"

  create_table "deliveries", :force => true do |t|
    t.text     "content"
    t.integer  "assignment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussions", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "role"
  end

  add_index "enrollments", ["course_id"], :name => "index_enrollments_on_course_id"
  add_index "enrollments", ["user_id"], :name => "index_enrollments_on_user_id"

  create_table "networks", :force => true do |t|
    t.string   "subdomain"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slogan"
    t.string   "welcome_message"
    t.string   "logo_file"
    t.string   "time_zone"
  end

  create_table "networks_users", :id => false, :force => true do |t|
    t.integer "network_id"
    t.integer "user_id"
  end

  add_index "networks_users", ["network_id"], :name => "index_networks_users_on_network_id"
  add_index "networks_users", ["user_id"], :name => "index_networks_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "role"
    t.integer  "network_id"
    t.string   "email",                                 :default => "",       :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "about_me"
    t.text     "studies"
    t.date     "birth_date"
    t.text     "occupation"
    t.string   "twitter_link"
    t.string   "facebook_link"
    t.string   "linkedin_link"
    t.string   "avatar_file"
    t.string   "state",                                 :default => "active"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

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

ActiveRecord::Schema.define(:version => 20120904204357) do

  create_table "answers", :id => false, :force => true do |t|
    t.string   "uuid",        :limit => 36
    t.integer  "question_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

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

  create_table "assignments", :force => true do |t|
    t.integer  "course_id"
    t.string   "name"
    t.text     "description"
    t.integer  "value"
    t.integer  "period"
    t.datetime "due_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_at"
    t.string   "state"
  end

  create_table "blogs", :force => true do |t|
    t.string   "post"
    t.text     "content"
    t.string   "menu_category"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user"
    t.integer  "user_id"
  end

  create_table "bug_answers", :force => true do |t|
    t.text     "container"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "send_report_id"
    t.string   "send_report_status"
    t.integer  "user_id"
  end

  create_table "calendar_activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user"
    t.integer  "user_id"
    t.date     "date_activity"
    t.datetime "due_to"
  end

  create_table "calificationems", :force => true do |t|
    t.integer  "raiting"
    t.text     "anotation_coment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delivery_id"
  end

  create_table "chats", :force => true do |t|
    t.string   "user"
    t.string   "text"
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "course"
    t.string   "user_name"
    t.integer  "course_id"
  end

  create_table "comment_posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "blog_id"
    t.string   "user"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "network_id"
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
    t.string   "course_logo_file"
    t.integer  "chat_id"
    t.string   "status"
  end

  add_index "courses", ["network_id"], :name => "index_courses_on_network_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "deliveries", :force => true do |t|
    t.text     "content"
    t.integer  "assignment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calificationem_id"
    t.integer  "raiting",           :default => 0
    t.text     "anotation_coment"
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

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_favorite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "name"
  end

  create_table "like_not_likes", :force => true do |t|
    t.integer  "like"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comment_id"
  end

  create_table "networks", :force => true do |t|
    t.string   "subdomain"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slogan"
    t.text     "welcome_message"
    t.string   "logo_file"
    t.string   "time_zone"
    t.boolean  "public_registry",  :default => true
    t.boolean  "private_registry", :default => false
    t.string   "registry_domain"
    t.string   "lenguajes"
    t.string   "variante",         :default => "free"
  end

  create_table "networks_users", :id => false, :force => true do |t|
    t.integer "network_id"
    t.integer "user_id"
  end

  add_index "networks_users", ["network_id"], :name => "index_networks_users_on_network_id"
  add_index "networks_users", ["user_id"], :name => "index_networks_users_on_user_id"

  create_table "new_users_change_types", :force => true do |t|
    t.integer  "new_old"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notificaciones_admin_actualice", :force => true do |t|
    t.string   "title",      :default => "Ahora notificaciones del administrador"
    t.string   "content",    :default => "Ahora puedes recibir notificaciones del administrador para estar siempre enterado de las actualizaciones del sistema"
    t.string   "link_video", :default => "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "notificator_id"
    t.string   "notificator_type"
    t.integer  "user_id"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
  end

  create_table "questions", :force => true do |t|
    t.integer  "survey_id"
    t.string   "answer_uuid"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value"
    t.integer  "position"
  end

  create_table "send_reports", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "event_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "typebug"
    t.string   "status"
  end

  create_table "status_courses", :force => true do |t|
    t.string   "status"
    t.date     "date"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "view_status"
    t.date     "date_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "survey_answers", :force => true do |t|
    t.integer  "survey_reply_id"
    t.integer  "question_id"
    t.string   "answer_uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_replies", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "course_id"
    t.string   "name"
    t.text     "description"
    t.integer  "value"
    t.integer  "period"
    t.datetime "due_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.datetime "start_at"
  end

  create_table "tutoriales", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "date"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "role"
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
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
    t.string   "state",                  :default => "active"
    t.boolean  "accepting_emails",       :default => false
    t.string   "authentication_token"
    t.integer  "chat_id"
    t.string   "calendar_activity"
    t.string   "view_status",            :default => "live"
    t.integer  "new_old",                :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

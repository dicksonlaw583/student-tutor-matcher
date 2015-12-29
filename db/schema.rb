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

ActiveRecord::Schema.define(:version => 20121202180044) do

  create_table "courses", :force => true do |t|
    t.string   "course_code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "professor_name"
  end

  create_table "favourites", :force => true do |t|
    t.integer  "favourite_tutor_id"
    t.integer  "liking_student_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "body"
    t.string   "subject"
    t.boolean  "read",         :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "offerings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.decimal  "price",      :precision => 6, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "rating_user_id"
    t.integer  "rated_user_id"
    t.integer  "amount"
    t.string   "comment"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "homepage_dir"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "name"
  end

  create_table "students", :force => true do |t|
    t.string   "user_name"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address"
    t.string   "phone"
    t.string   "program"
    t.string   "contact_method"
    t.integer  "year"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "tutors", :force => true do |t|
    t.string   "user_name"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address"
    t.string   "phone"
    t.decimal  "cgpa"
    t.string   "education_level"
    t.string   "contact_method"
    t.string   "personal_description"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "remember_token"
    t.integer  "role_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "phone"
    t.string   "program"
    t.string   "contact_method"
    t.integer  "year"
    t.decimal  "cgpa"
    t.string   "education_level"
    t.string   "personal_description"
    t.integer  "location_id"
  end

end

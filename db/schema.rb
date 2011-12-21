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

ActiveRecord::Schema.define(:version => 20111212072837) do

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "comment_count"
    t.string   "title"
    t.string   "digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "subject_id"
  end

  add_index "articles", ["subject_id"], :name => "index_articles_on_subject_id"
  add_index "articles", ["user_id"], :name => "index_articles_on_user_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "articles_count",                :default => 0
    t.integer  "users_count",                   :default => 0
    t.string   "info",           :limit => 200
    t.string   "preface",        :limit => 500
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["parent_id"], :name => "index_subjects_on_parent_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "avatar"
    t.integer  "subject_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["subject_id"], :name => "index_users_on_subject_id"

end

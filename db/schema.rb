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

ActiveRecord::Schema.define(version: 20140625223933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "languages", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["name"], name: "index_languages_on_name", unique: true, using: :btree

  create_table "repo_languages", force: true do |t|
    t.integer  "repo_id",     null: false
    t.integer  "language_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
  end

  add_index "repo_languages", ["repo_id", "language_id"], name: "index_repo_languages_on_repo_id_and_language_id", unique: true, using: :btree

  create_table "repos", force: true do |t|
    t.integer  "user_id",                           null: false
    t.string   "name",                              null: false
    t.string   "html_url",                          null: false
    t.boolean  "profile_visibility", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
  end

  add_index "repos", ["user_id", "name"], name: "index_repos_on_user_id_and_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "provider",     null: false
    t.string   "uid",          null: false
    t.string   "username",     null: false
    t.string   "email",        null: false
    t.string   "avatar_url",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
  end

  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end

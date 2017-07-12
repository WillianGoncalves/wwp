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

ActiveRecord::Schema.define(version: 20170712011332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "target_type", null: false
    t.integer  "target_id",   null: false
    t.index ["target_type", "target_id"], name: "index_comments_on_target_type_and_target_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "join_requests", force: :cascade do |t|
    t.boolean  "accepted"
    t.integer  "group_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_join_requests_on_group_id", using: :btree
    t.index ["user_id", "group_id"], name: "index_join_requests_on_user_id_and_group_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_join_requests_on_user_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.boolean  "admin"
    t.integer  "user_id",    null: false
    t.integer  "group_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_members_on_group_id", using: :btree
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "presentations", force: :cascade do |t|
    t.date     "date"
    t.time     "time"
    t.string   "local"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id",   null: false
    t.index ["group_id"], name: "index_presentations_on_group_id", using: :btree
  end

  create_table "presentations_songs", id: false, force: :cascade do |t|
    t.integer "song_id"
    t.integer "presentation_id"
    t.index ["presentation_id"], name: "index_songs_presentations_on_presentation_id", using: :btree
    t.index ["song_id"], name: "index_songs_presentations_on_song_id", using: :btree
  end

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "tone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id",   null: false
    t.index ["group_id"], name: "index_songs_on_group_id", using: :btree
  end

  create_table "songs_tags", id: false, force: :cascade do |t|
    t.integer "song_id"
    t.integer "tag_id"
    t.index ["song_id"], name: "index_songs_tags_on_song_id", using: :btree
    t.index ["tag_id"], name: "index_songs_tags_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "color_id",   null: false
    t.index ["color_id"], name: "index_tags_on_color_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar"
    t.integer  "last_group_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "comments", "users"
  add_foreign_key "join_requests", "groups"
  add_foreign_key "join_requests", "users"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "users"
  add_foreign_key "presentations", "groups"
  add_foreign_key "songs", "groups"
  add_foreign_key "users", "groups", column: "last_group_id"
end

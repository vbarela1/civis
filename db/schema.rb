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

ActiveRecord::Schema.define(version: 20170328175435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "web_url",        null: false
    t.string   "snippet",        null: false
    t.datetime "pub_date",       null: false
    t.string   "headline",       null: false
    t.string   "lead_paragraph", null: false
    t.integer  "rep_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["rep_id"], name: "index_articles_on_rep_id", using: :btree
  end

  create_table "reps", force: :cascade do |t|
    t.string   "title",           default: "", null: false
    t.string   "first_name",      default: "", null: false
    t.string   "last_name",       default: "", null: false
    t.string   "state",           default: "", null: false
    t.string   "party"
    t.string   "district"
    t.string   "phone"
    t.string   "url"
    t.string   "next_election"
    t.string   "twitter_account"
    t.string   "profile_url",     default: ""
    t.string   "contact_url",     default: ""
    t.integer  "new_articles",    default: 0,  null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "bio",             default: ""
  end

  create_table "ties", force: :cascade do |t|
    t.integer  "new_articles", default: 0
    t.boolean  "subscription", default: false
    t.integer  "rep_id",                       null: false
    t.integer  "user_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["rep_id"], name: "index_ties_on_rep_id", using: :btree
    t.index ["user_id"], name: "index_ties_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "first_name",             default: ""
    t.string   "last_name",              default: ""
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "articles", "reps"
end

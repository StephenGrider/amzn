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

ActiveRecord::Schema.define(version: 20150124011059) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "items", force: :cascade do |t|
    t.string   "description"
    t.string   "price"
    t.string   "image_url"
    t.string   "url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "title"
    t.string   "asin"
    t.string   "brand"
    t.string   "wishlist_url"
    t.string   "tell_friend_url"
    t.integer  "search_node_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "item_id"
    t.integer  "user_id"
  end

  add_index "line_items", ["item_id"], name: "index_line_items_on_item_id"
  add_index "line_items", ["user_id"], name: "index_line_items_on_user_id"

  create_table "logs", force: :cascade do |t|
    t.text     "json"
    t.text     "message"
    t.text     "asin"
    t.integer  "page_fetched"
    t.integer  "total_pages"
    t.boolean  "success"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "search_node_id"
  end

  create_table "search_nodes", force: :cascade do |t|
    t.boolean  "enabled"
    t.string   "category"
    t.string   "parent_category"
    t.integer  "amazon_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "imei"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

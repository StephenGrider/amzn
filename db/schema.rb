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

ActiveRecord::Schema.define(version: 20150413162307) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "description",     limit: 255
    t.string   "price",           limit: 255
    t.string   "image_url",       limit: 255
    t.string   "url",             limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "title",           limit: 255
    t.string   "asin",            limit: 255
    t.string   "brand",           limit: 255
    t.string   "wishlist_url",    limit: 255
    t.string   "tell_friend_url", limit: 255
    t.integer  "search_node_id",  limit: 4
  end

  create_table "line_items", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "item_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "liked",      limit: 1
  end

  add_index "line_items", ["item_id"], name: "index_line_items_on_item_id", using: :btree
  add_index "line_items", ["user_id"], name: "index_line_items_on_user_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.text     "json",           limit: 65535
    t.text     "message",        limit: 65535
    t.text     "asin",           limit: 65535
    t.integer  "page_fetched",   limit: 4
    t.integer  "total_pages",    limit: 4
    t.boolean  "success",        limit: 1
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "search_node_id", limit: 4
  end

  create_table "reviewables", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "item_id",        limit: 4
    t.integer  "line_item_id",   limit: 4
    t.integer  "share_queue_id", limit: 4
  end

  create_table "search_nodes", force: :cascade do |t|
    t.boolean  "enabled",         limit: 1
    t.string   "category",        limit: 255
    t.string   "parent_category", limit: 255
    t.integer  "vendor_id",       limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "vendor",          limit: 255
  end

  create_table "share_queues", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "creator_id",   limit: 4
    t.integer  "recipient_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "guid",                   limit: 255
    t.boolean  "admin",                  limit: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

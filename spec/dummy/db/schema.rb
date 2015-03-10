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

ActiveRecord::Schema.define(version: 20150310042459) do

  create_table "configurations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "color"
    t.string   "age"
    t.string   "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "paused",     default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "trackable_events", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "category"
    t.string   "event"
    t.string   "new_value"
    t.string   "old_value"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "trackable_events", ["owner_id", "owner_type"], name: "index_trackable_events_on_owner_id_and_owner_type"
  add_index "trackable_events", ["trackable_id", "trackable_type"], name: "index_trackable_events_on_trackable_id_and_trackable_type"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

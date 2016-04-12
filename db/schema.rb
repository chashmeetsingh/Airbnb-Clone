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

ActiveRecord::Schema.define(version: 20160411212822) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "cust_id"
    t.integer  "provider_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "description"
    t.string   "stripeToken"
    t.string   "stripe_customer_id"
    t.integer  "price"
    t.boolean  "paid",               default: false
    t.boolean  "accept",             default: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dogs", force: :cascade do |t|
    t.string   "name"
    t.string   "gender"
    t.string   "breed"
    t.string   "size"
    t.text     "description"
    t.string   "image_url"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "year"
    t.integer  "month"
  end

  add_index "dogs", ["user_id"], name: "index_dogs_on_user_id"

  create_table "favourites", force: :cascade do |t|
    t.integer  "cust_id"
    t.integer  "provider_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "stripe_customers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_customer_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "phone_no"
    t.string   "profile_image"
    t.float    "lat"
    t.float    "lng"
    t.integer  "per_day_price",          default: 5
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end

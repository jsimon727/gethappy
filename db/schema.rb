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

ActiveRecord::Schema.define(version: 20140218171238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bars", force: true do |t|
    t.string  "name"
    t.string  "operation_hour"
    t.text    "review"
    t.string  "contact"
    t.integer "location_id"
  end

  create_table "deals", force: true do |t|
    t.string  "name"
    t.string  "type"
    t.integer "deal_price"
    t.integer "original_price"
    t.text    "info"
    t.integer "location_id"
    t.integer "user_id"
  end

  create_table "favorites", force: true do |t|
    t.integer "user_id"
    t.integer "location_id"
  end

  create_table "locations", force: true do |t|
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "address"
    t.string "name"
    t.string "zip_code"
  end

  create_table "users", force: true do |t|
    t.string  "firstname"
    t.string  "lastname"
    t.string  "email"
    t.date    "dob"
    t.text    "facebook_link"
    t.string  "password_digest"
    t.float   "latitude"
    t.float   "longitude"
    t.integer "ip_address"
  end

end

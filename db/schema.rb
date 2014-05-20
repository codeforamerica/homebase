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

ActiveRecord::Schema.define(version: 20140519181919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "permits", force: true do |t|
    t.string   "owner_name"
    t.string   "owner_address"
    t.boolean  "addition"
    t.integer  "house_area"
    t.integer  "addition_area"
    t.string   "ac"
    t.boolean  "contractor"
    t.string   "contractor_name"
    t.string   "contractor_id"
    t.boolean  "escrow"
    t.string   "license_holder"
    t.string   "license_num"
    t.string   "agent_name"
    t.string   "contact_id"
    t.string   "other_contact_id"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.text     "work_summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "job_cost"
  end

  create_table "spatial_ref_sys", id: false, force: true do |t|
    t.integer "srid",                   null: false
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

end

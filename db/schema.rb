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

ActiveRecord::Schema.define(version: 20140723232313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "binaries", force: true do |t|
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cosa_boundaries", force: true do |t|
    t.string   "name"
    t.float    "sqmiles"
    t.float    "shape_area"
    t.float    "shape_leng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "geom",       limit: {:srid=>0, :type=>"geometry"}
    t.float    "acres"
  end

  create_table "permit_binary_details", force: true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "binary_id"
    t.integer  "permit_id"
  end

  add_index "permit_binary_details", ["binary_id"], :name => "index_permit_binary_details_on_binary_id"
  add_index "permit_binary_details", ["permit_id"], :name => "index_permit_binary_details_on_permit_id"

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
    t.decimal  "job_cost",         precision: 15, scale: 2
    t.string   "status"
    t.boolean  "window"
    t.boolean  "door"
    t.boolean  "wall"
    t.boolean  "siding"
    t.boolean  "floor"
    t.integer  "window_count"
    t.integer  "door_count"
    t.boolean  "cover"
    t.boolean  "pool"
    t.boolean  "deck"
    t.boolean  "acs_struct"
    t.boolean  "accepted_terms"
  end

end

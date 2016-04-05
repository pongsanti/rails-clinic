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

ActiveRecord::Schema.define(version: 20160405161154) do

  create_table "customers", force: :cascade do |t|
    t.string   "cn",           null: false
    t.string   "name"
    t.string   "surname"
    t.string   "sex"
    t.string   "id_card_no"
    t.string   "passport_no"
    t.date     "birthdate"
    t.string   "address"
    t.string   "sub_district"
    t.string   "district"
    t.string   "province"
    t.string   "postal_code"
    t.string   "occupation"
    t.string   "tel_no"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "prefix_id"
  end

  add_index "customers", ["prefix_id"], name: "index_customers_on_prefix_id"

  create_table "prefixes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

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

ActiveRecord::Schema.define(version: 20160706023525) do

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "display_name"
    t.string   "owner_name"
    t.string   "owner_surname"
    t.string   "email"
    t.string   "address"
    t.string   "sub_district"
    t.string   "district"
    t.string   "province"
    t.string   "postal_code"
    t.string   "home_phone_no"
    t.string   "mobile_phone_no"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "cn",            null: false
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
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "prefix_id"
    t.string   "home_phone_no"
    t.string   "nationality"
    t.string   "email"
  end

  add_index "customers", ["prefix_id"], name: "index_customers_on_prefix_id"

  create_table "diags", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "drug_ins", force: :cascade do |t|
    t.integer  "amount"
    t.date     "expired_date"
    t.decimal  "cost",                precision: 8, scale: 2
    t.decimal  "sale_price_per_unit", precision: 8, scale: 2
    t.integer  "balance"
    t.integer  "drug_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "drug_ins", ["drug_id"], name: "index_drug_ins_on_drug_id"

  create_table "drug_usages", force: :cascade do |t|
    t.string   "code"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drugs", force: :cascade do |t|
    t.text     "name"
    t.text     "trade_name"
    t.text     "effect"
    t.integer  "balance"
    t.integer  "drug_usage_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "store_unit_id"
    t.string   "concern"
  end

  add_index "drugs", ["drug_usage_id"], name: "index_drugs_on_drug_usage_id"
  add_index "drugs", ["store_unit_id"], name: "index_drugs_on_store_unit_id"

  create_table "exams", force: :cascade do |t|
    t.decimal  "weight"
    t.decimal  "height"
    t.integer  "bp_systolic"
    t.integer  "bp_diastolic"
    t.integer  "pulse"
    t.text     "drug_allergy"
    t.text     "note"
    t.text     "exam_pi"
    t.text     "exam_pe"
    t.text     "exam_note"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "customer_id"
    t.integer  "examiner_id"
  end

  add_index "exams", ["customer_id"], name: "index_exams_on_customer_id"
  add_index "exams", ["examiner_id"], name: "index_exams_on_examiner_id"

  create_table "patient_diags", force: :cascade do |t|
    t.integer  "exam_id"
    t.integer  "diag_id"
    t.integer  "order"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "patient_diags", ["diag_id"], name: "index_patient_diags_on_diag_id"
  add_index "patient_diags", ["exam_id"], name: "index_patient_diags_on_exam_id"

  create_table "prefixes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "qs", force: :cascade do |t|
    t.string   "category"
    t.integer  "exam_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "qs", ["exam_id"], name: "index_qs_on_exam_id"

  create_table "store_units", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer  "client_id"
    t.string   "role"
  end

  add_index "users", ["client_id"], name: "index_users_on_client_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

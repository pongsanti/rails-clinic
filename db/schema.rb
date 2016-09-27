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

ActiveRecord::Schema.define(version: 20160927161323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.date     "date"
    t.time     "time"
    t.integer  "exam_id"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "appointments", ["exam_id"], name: "index_appointments_on_exam_id", using: :btree

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
    t.datetime "deleted_at"
    t.string   "street"
  end

  add_index "customers", ["deleted_at"], name: "index_customers_on_deleted_at", using: :btree
  add_index "customers", ["prefix_id"], name: "index_customers_on_prefix_id", using: :btree

  create_table "diags", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
  end

  add_index "diags", ["deleted_at"], name: "index_diags_on_deleted_at", using: :btree

  create_table "drug_ins", force: :cascade do |t|
    t.date     "expired_date"
    t.decimal  "cost",                precision: 8, scale: 2
    t.decimal  "sale_price_per_unit", precision: 8, scale: 2
    t.integer  "balance"
    t.integer  "drug_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.datetime "deleted_at"
  end

  add_index "drug_ins", ["deleted_at"], name: "index_drug_ins_on_deleted_at", using: :btree
  add_index "drug_ins", ["drug_id"], name: "index_drug_ins_on_drug_id", using: :btree

  create_table "drug_movements", force: :cascade do |t|
    t.decimal  "balance"
    t.decimal  "prev_bal"
    t.string   "note"
    t.integer  "drug_in_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "patient_drug_id"
  end

  add_index "drug_movements", ["drug_in_id"], name: "index_drug_movements_on_drug_in_id", using: :btree
  add_index "drug_movements", ["patient_drug_id"], name: "index_drug_movements_on_patient_drug_id", using: :btree

  create_table "drug_usages", force: :cascade do |t|
    t.string   "code"
    t.string   "text"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "times_per_day"
    t.decimal  "use_amount",    precision: 4, scale: 1
    t.datetime "deleted_at"
  end

  add_index "drug_usages", ["deleted_at"], name: "index_drug_usages_on_deleted_at", using: :btree

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
    t.datetime "deleted_at"
  end

  add_index "drugs", ["deleted_at"], name: "index_drugs_on_deleted_at", using: :btree
  add_index "drugs", ["drug_usage_id"], name: "index_drugs_on_drug_usage_id", using: :btree
  add_index "drugs", ["store_unit_id"], name: "index_drugs_on_store_unit_id", using: :btree

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
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "customer_id"
    t.integer  "examiner_id"
    t.decimal  "revenue",      precision: 9, scale: 2
    t.boolean  "paid_status"
  end

  add_index "exams", ["customer_id"], name: "index_exams_on_customer_id", using: :btree
  add_index "exams", ["examiner_id"], name: "index_exams_on_examiner_id", using: :btree

  create_table "patient_diags", force: :cascade do |t|
    t.integer  "exam_id"
    t.integer  "diag_id"
    t.integer  "order"
    t.string   "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "patient_diags", ["diag_id"], name: "index_patient_diags_on_diag_id", using: :btree
  add_index "patient_diags", ["exam_id"], name: "index_patient_diags_on_exam_id", using: :btree

  create_table "patient_drugs", force: :cascade do |t|
    t.integer  "exam_id"
    t.integer  "drug_in_id"
    t.integer  "drug_usage_id"
    t.decimal  "amount",        precision: 4, scale: 1
    t.decimal  "revenue",       precision: 9, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "patient_drugs", ["drug_in_id"], name: "index_patient_drugs_on_drug_in_id", using: :btree
  add_index "patient_drugs", ["drug_usage_id"], name: "index_patient_drugs_on_drug_usage_id", using: :btree
  add_index "patient_drugs", ["exam_id"], name: "index_patient_drugs_on_exam_id", using: :btree

  create_table "prefixes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sex"
  end

  create_table "qs", force: :cascade do |t|
    t.string   "category"
    t.integer  "exam_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "active"
  end

  add_index "qs", ["exam_id"], name: "index_qs_on_exam_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "store_units", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "store_units", ["deleted_at"], name: "index_store_units_on_deleted_at", using: :btree

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
    t.string   "display_name"
    t.integer  "role_id"
  end

  add_index "users", ["client_id"], name: "index_users_on_client_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "appointments", "exams"
  add_foreign_key "customers", "prefixes"
  add_foreign_key "drug_ins", "drugs"
  add_foreign_key "drug_movements", "drug_ins"
  add_foreign_key "drug_movements", "patient_drugs"
  add_foreign_key "drugs", "drug_usages"
  add_foreign_key "drugs", "store_units"
  add_foreign_key "exams", "customers"
  add_foreign_key "exams", "users", column: "examiner_id"
  add_foreign_key "patient_diags", "diags"
  add_foreign_key "patient_diags", "exams"
  add_foreign_key "patient_drugs", "drug_ins"
  add_foreign_key "patient_drugs", "drug_usages"
  add_foreign_key "patient_drugs", "exams"
  add_foreign_key "qs", "exams"
  add_foreign_key "users", "clients"
  add_foreign_key "users", "roles"
end

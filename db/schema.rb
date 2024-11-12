# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_12_105707) do
  create_table "coaches_coaching_programs", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.bigint "coach_id", null: false
    t.bigint "coaching_program_id", null: false
  end

  create_table "coaching_programs", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "company_id"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_coaching_programs_on_company_id"
  end

  create_table "coaching_programs_companies", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "coaching_program_id", null: false
  end

  create_table "companies", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "domain", null: false
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "role", null: false
    t.boolean "active", default: true, null: false
    t.bigint "company_id"
    t.bigint "coaching_program_id"
    t.text "coaching_requirements"
    t.bigint "coach_id"
    t.index ["coaching_program_id"], name: "index_users_on_coaching_program_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "users", "coaching_programs"
  add_foreign_key "users", "companies"
end

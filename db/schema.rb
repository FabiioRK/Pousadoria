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

ActiveRecord::Schema[7.1].define(version: 2023_11_08_013632) do
  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "district"
    t.string "state"
    t.string "city"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inn_id", null: false
    t.index ["inn_id"], name: "index_addresses_on_inn_id"
  end

  create_table "custom_prices", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "price"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_custom_prices_on_room_id"
  end

  create_table "inns", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "registration_number"
    t.string "phone_number"
    t.string "contact_email"
    t.boolean "pet_allowed"
    t.time "checkin_time", default: "2000-01-01 12:00:00"
    t.time "checkout_time", default: "2000-01-01 14:00:00"
    t.text "description"
    t.text "usage_policies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "payment_methods"
    t.boolean "active", default: true
    t.index ["user_id"], name: "index_inns_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer "method", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "dimension"
    t.integer "max_accommodation"
    t.integer "standard_price"
    t.boolean "has_bathroom"
    t.boolean "has_balcony"
    t.boolean "has_air_conditioner"
    t.boolean "has_tv"
    t.boolean "has_closet"
    t.boolean "has_safe"
    t.boolean "is_disabled_accessible"
    t.integer "inn_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["inn_id"], name: "index_rooms_on_inn_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "account_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "inns"
  add_foreign_key "custom_prices", "rooms"
  add_foreign_key "inns", "users"
  add_foreign_key "rooms", "inns"
end

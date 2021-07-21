# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email", "reset_password_token"], name: "index_admins_on_email_and_reset_password_token", unique: true
  end

  create_table "jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "job_id"
    t.integer "pref_id"
    t.string "name", default: "", null: false
    t.string "name_kana"
    t.string "nickname"
    t.string "phone", limit: 11
    t.date "birthday"
    t.integer "gender"
    t.string "work_place"
    t.text "self_introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email", "reset_password_token"], name: "index_mentors_on_email_and_reset_password_token", unique: true
  end

  create_table "prefs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "mentor_id"
    t.string "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "reservation_status", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["mentor_id"], name: "index_reservations_on_mentor_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "job_id"
    t.integer "pref_id"
    t.string "name", default: "", null: false
    t.string "name_kana"
    t.string "nickname"
    t.string "phone", limit: 11
    t.date "birthday"
    t.integer "gender"
    t.string "work_place"
    t.text "self_introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email", "reset_password_token"], name: "index_users_on_email_and_reset_password_token", unique: true
  end

  add_foreign_key "reservations", "mentors"
  add_foreign_key "reservations", "users"
end

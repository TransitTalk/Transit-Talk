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

ActiveRecord::Schema.define(version: 20170225193345) do

  create_table "issues", force: :cascade do |t|
    t.integer "type"
    t.integer "stop_id"
    t.integer "vehicle_id"
    t.text    "description"
    t.integer "user_id"
    t.index ["stop_id"], name: "index_issues_on_stop_id"
    t.index ["user_id"], name: "index_issues_on_user_id"
    t.index ["vehicle_id"], name: "index_issues_on_vehicle_id"
  end

  create_table "lines", force: :cascade do |t|
    t.string  "api_id"
    t.string  "name"
    t.integer "system_type"
  end

  create_table "lines_stops", force: :cascade do |t|
    t.integer "stop_id"
    t.integer "line_id"
    t.index ["line_id"], name: "index_lines_stops_on_line_id"
    t.index ["stop_id"], name: "index_lines_stops_on_stop_id"
  end

  create_table "stops", force: :cascade do |t|
    t.string  "api_id"
    t.string  "name"
    t.string  "direction"
    t.decimal "longitude"
    t.decimal "lattitude"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string  "api_id"
    t.integer "line_id"
    t.index ["line_id"], name: "index_vehicles_on_line_id"
  end

end

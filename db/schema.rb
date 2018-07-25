# This file is auto-generated from the current state of the database. Instead

ActiveRecord::Schema.define(version: 20170913013817) do

  create_table "issues", force: :cascade do |t|
    t.string   "stop_onestop_id"
    t.integer  "vehicle_id"
    t.text     "description"
    t.integer  "user_id"
    t.string   "line_onestop_id"
    t.string   "types"
    t.boolean  "resolved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["stop_onestop_id"], name: "index_issues_on_stop_onestop_id"
    t.index ["user_id"], name: "index_issues_on_user_id"
    t.index ["vehicle_id"], name: "index_issues_on_vehicle_id"
  end

  create_table "lines", force: :cascade do |t|
    t.string  "route_long_name"
    t.string  "name"
    t.integer "system_type"
    t.string  "color"
    t.string  "onestop_id"
    t.string  "vehicle_type"
    t.string  "wheelchair_accessible"
    t.string  "bikes_allowed"
    t.index ["onestop_id"], name: "index_lines_on_onestop_id"
    t.index ["route_long_name"], name: "index_lines_on_route_long_name"
  end

  create_table "lines_stops", force: :cascade do |t|
    t.string "stop_onestop_id"
    t.string "line_onestop_id"
    t.index ["line_onestop_id"], name: "index_lines_stops_on_line_onestop_id"
    t.index ["stop_onestop_id"], name: "index_lines_stops_on_stop_onestop_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "stops", force: :cascade do |t|
    t.string  "api_id"
    t.string  "name"
    t.decimal "longitude",    precision: 12, scale: 8
    t.decimal "lattitude",    precision: 12, scale: 8
    t.integer "twin_stop_id"
    t.string  "onestop_id"
    t.index ["api_id"], name: "index_stops_on_api_id"
    t.index ["onestop_id"], name: "index_stops_on_onestop_id"
  end

  create_table "stops_users", force: :cascade do |t|
    t.integer "user_id"
    t.string  "stop_onestop_id"
    t.index ["stop_onestop_id"], name: "index_stops_users_on_stop_onestop_id"
    t.index ["user_id"], name: "index_stops_users_on_user_id"
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
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string  "api_id"
    t.integer "line_id"
    t.index ["api_id"], name: "index_vehicles_on_api_id"
    t.index ["line_id"], name: "index_vehicles_on_line_id"
  end

end

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

ActiveRecord::Schema.define(version: 20140215003546) do

  create_table "app_setups", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apps", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apps", ["user_id"], name: "index_apps_on_user_id"

  create_table "apps_environments", force: true do |t|
    t.integer "app_id"
    t.integer "environment_id"
  end

  add_index "apps_environments", ["app_id", "environment_id"], name: "index_apps_environments_on_app_id_and_environment_id", unique: true

  create_table "authentication_types", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deploy_option_types", force: true do |t|
    t.string "name"
  end

  create_table "deploy_options", force: true do |t|
    t.string   "value"
    t.integer  "deploy_option_type_id"
    t.integer  "deploy_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deploy_options", ["deploy_id"], name: "index_deploy_options_on_deploy_id"
  add_index "deploy_options", ["deploy_option_type_id"], name: "index_deploy_options_on_deploy_option_type_id"

  create_table "deploy_step_type_options", force: true do |t|
    t.string  "name"
    t.integer "deploy_step_type_id"
  end

  add_index "deploy_step_type_options", ["deploy_step_type_id"], name: "index_deploy_step_type_options_on_deploy_step_type_id"

  create_table "deploy_step_types", force: true do |t|
    t.string "name"
    t.string "subtype", default: "generic"
  end

  create_table "deploy_steps", force: true do |t|
    t.integer  "order",                      default: 0
    t.integer  "deploy_step_type_option_id"
    t.string   "value"
    t.string   "additional",                 default: "{}"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "environment_id"
  end

  add_index "deploy_steps", ["deploy_step_type_option_id"], name: "index_deploy_steps_on_deploy_step_type_option_id"
  add_index "deploy_steps", ["environment_id"], name: "index_deploy_steps_on_environment_id"

  create_table "deploys", force: true do |t|
    t.string   "status",         default: "pending"
    t.text     "output",         default: ""
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "environment_id"
  end

  add_index "deploys", ["environment_id"], name: "index_deploys_on_environment_id"
  add_index "deploys", ["user_id"], name: "index_deploys_on_user_id"

  create_table "environments", force: true do |t|
    t.string   "name"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "environments_servers", force: true do |t|
    t.integer "environment_id"
    t.integer "server_id"
  end

  add_index "environments_servers", ["environment_id", "server_id"], name: "index_environments_servers_on_environment_id_and_server_id", unique: true

  create_table "servers", force: true do |t|
    t.string   "name"
    t.string   "host"
    t.string   "username"
    t.integer  "authentication_type_id"
    t.text     "authentication"
    t.integer  "user_id"
    t.boolean  "enabled",                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_sudo",               default: false
    t.string   "sudo_password"
  end

  add_index "servers", ["user_id"], name: "index_servers_on_user_id"

  create_table "users", force: true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end

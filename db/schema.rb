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

ActiveRecord::Schema.define(version: 20140506161120) do

  create_table "access_levels", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.string   "access_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apps", force: true do |t|
    t.string   "name"
    t.integer  "organisation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apps", ["organisation_id"], name: "index_apps_on_organisation_id"

  create_table "authentication_types", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deploy_option_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "name"
    t.integer  "deploy_step_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deploy_step_type_options", ["deploy_step_type_id"], name: "index_deploy_step_type_options_on_deploy_step_type_id"
  add_index "deploy_step_type_options", ["name"], name: "index_deploy_step_type_options_on_name", unique: true

  create_table "deploy_step_types", force: true do |t|
    t.string   "name"
    t.string   "subtype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deploy_step_types", ["name"], name: "index_deploy_step_types_on_name", unique: true

  create_table "deploy_steps", force: true do |t|
    t.integer  "env_id"
    t.integer  "order"
    t.integer  "deploy_step_type_option_id"
    t.string   "value"
    t.string   "additional"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deploy_steps", ["deploy_step_type_option_id"], name: "index_deploy_steps_on_deploy_step_type_option_id"
  add_index "deploy_steps", ["env_id"], name: "index_deploy_steps_on_env_id"

  create_table "deploys", force: true do |t|
    t.string   "status"
    t.text     "output"
    t.integer  "server_id"
    t.integer  "env_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deploys", ["env_id"], name: "index_deploys_on_env_id"
  add_index "deploys", ["server_id"], name: "index_deploys_on_server_id"
  add_index "deploys", ["user_id"], name: "index_deploys_on_user_id"

  create_table "env_servers", force: true do |t|
    t.integer  "env_id"
    t.integer  "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "env_servers", ["env_id"], name: "index_env_servers_on_env_id"
  add_index "env_servers", ["server_id"], name: "index_env_servers_on_server_id"

  create_table "env_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "env_id"
    t.integer  "access_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "env_users", ["access_level_id"], name: "index_env_users_on_access_level_id"
  add_index "env_users", ["env_id"], name: "index_env_users_on_env_id"
  add_index "env_users", ["user_id"], name: "index_env_users_on_user_id"

  create_table "envs", force: true do |t|
    t.string   "name"
    t.integer  "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "envs", ["app_id"], name: "index_envs_on_app_id"

  create_table "organisation_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.integer  "access_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organisation_users", ["access_level_id"], name: "index_organisation_users_on_access_level_id"
  add_index "organisation_users", ["organisation_id"], name: "index_organisation_users_on_organisation_id"
  add_index "organisation_users", ["user_id"], name: "index_organisation_users_on_user_id"

  create_table "organisations", force: true do |t|
    t.string   "name"
    t.string   "access_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organisations", ["access_code"], name: "index_organisations_on_access_code", unique: true

  create_table "servers", force: true do |t|
    t.integer  "organisation_id"
    t.string   "name"
    t.string   "host"
    t.integer  "port"
    t.string   "username"
    t.integer  "authentication_type_id"
    t.text     "authentication"
    t.boolean  "enabled"
    t.boolean  "can_sudo"
    t.string   "sudo_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "servers", ["authentication_type_id"], name: "index_servers_on_authentication_type_id"
  add_index "servers", ["organisation_id"], name: "index_servers_on_organisation_id"

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
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end

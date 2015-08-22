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

ActiveRecord::Schema.define(version: 20150821123053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cats", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "sex"
    t.integer  "age"
    t.date     "date_trapped"
    t.boolean  "altered"
    t.boolean  "eartipped"
    t.string   "rabies_tag"
    t.string   "distemper"
    t.string   "microchip"
    t.string   "photo"
    t.integer  "colony_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "cats", ["colony_id"], name: "index_cats_on_colony_id", unique: true, using: :btree

  create_table "colonies", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "photo"
    t.string   "street_address", null: false
    t.string   "city",           null: false
    t.string   "state",          null: false
    t.string   "zip_code"
    t.string   "enviroment"
    t.integer  "pop"
    t.string   "vet"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "colony_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "colony_id"
    t.boolean  "owner"
    t.boolean  "volunteer"
    t.boolean  "care_taker"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "colony_users", ["user_id", "colony_id"], name: "index_colony_users_on_user_id_and_colony_id", unique: true, using: :btree

  create_table "organization_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organization_users", ["user_id", "organization_id"], name: "index_organization_users_on_user_id_and_organization_id", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",           null: false
    t.text     "description"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "display_name",                        null: false
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.integer  "age"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.text     "about_me"
    t.string   "pets"
    t.text     "volunteer_work"
  end

  add_index "users", ["display_name"], name: "index_users_on_display_name", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

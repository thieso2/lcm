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

ActiveRecord::Schema.define(version: 20150202203813) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "group_id"
    t.integer  "role_type_id"
    t.date     "startdate"
    t.date     "enddate"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "assignments", ["group_id"], name: "index_assignments_on_group_id"
  add_index "assignments", ["person_id"], name: "index_assignments_on_person_id"
  add_index "assignments", ["role_type_id"], name: "index_assignments_on_role_type_id"

  create_table "group_types", force: :cascade do |t|
    t.string   "description",             null: false
    t.integer  "category",    default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "group_type_id"
    t.integer  "eid"
    t.string   "shortname"
    t.string   "title"
    t.string   "location"
    t.date     "startdate"
    t.date     "enddate"
    t.decimal  "baseprice",     precision: 8, scale: 2
    t.integer  "group_state",                           default: 0, null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "groups", ["group_type_id"], name: "index_groups_on_group_type_id"

  create_table "people", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "sex"
    t.integer  "salutation"
    t.string   "country"
    t.string   "region"
    t.string   "zip"
    t.string   "city"
    t.string   "street"
    t.string   "phone_private"
    t.string   "phone_work"
    t.string   "phone_mobile"
    t.string   "notes"
    t.integer  "pid"
    t.boolean  "do_not_contact"
    t.integer  "access"
  end

  add_index "people", ["email"], name: "index_people_on_email"
  add_index "people", ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true

  create_table "role_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end

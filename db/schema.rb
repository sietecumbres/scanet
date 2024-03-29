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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110323024422) do

  create_table "logins", :force => true do |t|
    t.integer  "user_id"
    t.string   "token",          :null => false
    t.string   "ip_address"
    t.string   "remote_address"
    t.string   "user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email",                                 :null => false
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "verification_token"
    t.boolean  "admin",              :default => false
    t.boolean  "verified",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "windows_wmi_classes", :force => true do |t|
    t.integer  "wmi_namespace_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "windows_wmi_namespaces", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "windows_wmi_properties", :force => true do |t|
    t.integer  "wmi_class_id"
    t.string   "name"
    t.string   "class_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

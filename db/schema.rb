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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121109030444) do

  create_table "assets", :force => true do |t|
    t.integer  "page_id"
    t.integer  "size"
    t.string   "path"
    t.string   "md5"
    t.string   "asset_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "audits", :force => true do |t|
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.text     "path"
    t.integer  "site_id"
    t.integer  "discovered_id"
    t.integer  "response_time"
    t.integer  "response_code"
    t.datetime "last_audited_at"
    t.string   "last_error"
    t.datetime "last_error_at"
    t.string   "digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "reports", :force => true do |t|
    t.text     "message"
    t.integer  "score"
    t.integer  "page_id"
    t.integer  "audit_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sites", :force => true do |t|
    t.text     "site_name"
    t.text     "description"
    t.text     "url"
    t.integer  "port"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end

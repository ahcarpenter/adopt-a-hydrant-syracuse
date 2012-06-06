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

ActiveRecord::Schema.define(:version => 20120606183337) do

  create_table 'rails_admin_histories', :force => true do |t|
    t.string   'message'
    t.string   'username'
    t.integer  'item'
    t.string   'table'
    t.integer  'month',      :limit => 2
    t.integer  'year',       :limit => 8
    t.datetime 'created_at',              :null => false
    t.datetime 'updated_at',              :null => false
  end

  add_index 'rails_admin_histories', ['item', 'table', 'month', 'year'], :name => 'index_rails_admin_histories'

  create_table 'reminders', :force => true do |t|
    t.datetime 'created_at',                      :null => false
    t.datetime 'updated_at',                      :null => false
    t.integer  'from_user_id',                    :null => false
    t.integer  'to_user_id',                      :null => false
    t.integer  'thing_id',                        :null => false
    t.boolean  'sent',         :default => false
  end

  add_index 'reminders', ['from_user_id'], :name => 'index_reminders_on_from_user_id'
  add_index 'reminders', ['sent'], :name => 'index_reminders_on_sent'
  add_index 'reminders', ['thing_id'], :name => 'index_reminders_on_thing_id'
  add_index 'reminders', ['to_user_id'], :name => 'index_reminders_on_to_user_id'

  create_table 'sessions', :id => false, :force => true do |t|
    t.string   'session_id', :null => false
    t.text     'data'
    t.datetime 'created_at', :null => false
    t.datetime 'updated_at', :null => false
  end

  add_index 'sessions', ['session_id'], :name => 'index_sessions_on_session_id'
  add_index 'sessions', ['updated_at'], :name => 'index_sessions_on_updated_at'

  create_table 'things', :force => true do |t|
    t.datetime 'created_at',                                                    :null => false
    t.datetime 'updated_at',                                                    :null => false
    t.string   'name'
    t.decimal  'lat',          :precision => 18, :scale => 14,                  :null => false
    t.decimal  'lng',          :precision => 18, :scale => 14,                  :null => false
    t.integer  'user_id'
    t.decimal  'snow_cover',   :precision => 5,  :scale => 2,  :default => 0.0
    t.integer  'lock_version',                                 :default => 0,   :null => false
  end

  create_table 'users', :force => true do |t|
    t.datetime 'created_at',                                :null => false
    t.datetime 'updated_at',                                :null => false
    t.string   'name',                                      :null => false
    t.string   'organization'
    t.string   'email',                                     :null => false
    t.string   'voice_number'
    t.string   'sms_number'
    t.boolean  'admin',                  :default => false
    t.string   'address_1'
    t.string   'address_2'
    t.string   'city'
    t.string   'state'
    t.string   'zip'
    t.datetime 'reset_password_sent_at'
  end

  add_index 'users', ['email'], :name => 'index_users_on_email', :unique => true

  add_foreign_key 'reminders', 'things', :name => 'reminders_thing_id_fk'
  add_foreign_key 'reminders', 'users', :name => 'reminders_from_user_id_fk', :column => 'from_user_id'
  add_foreign_key 'reminders', 'users', :name => 'reminders_to_user_id_fk', :column => 'to_user_id'

  add_foreign_key 'things', 'users', :name => 'things_user_id_fk'
end
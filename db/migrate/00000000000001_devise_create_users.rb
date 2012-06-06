class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :name, :null => false
      t.string :organization
      t.string :email, :null => false, :unique => true
      t.string :voice_number
      t.string :sms_number
      t.boolean :admin, :default => false
      t.string   'encrypted_password', :limit => 128, :default => '', :null => false
      t.string   'reset_password_token'
      t.string   'remember_token'
      t.datetime 'remember_created_at'
      t.integer  'sign_in_count', :default => 0
      t.datetime 'current_sign_in_at'
      t.datetime 'last_sign_in_at'
      t.string   'current_sign_in_ip'
      t.string   'last_sign_in_ip'
    end

    add_index :users, :email, :unique => true
  end
end
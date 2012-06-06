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
    end

    add_index :users, :email, :unique => true
  end
end
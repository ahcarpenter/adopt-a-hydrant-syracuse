class AddSmsNotificationsToThings < ActiveRecord::Migration
  def change
    add_column :things, :sms_notifications, :bool, :default => false
  end
end
class AddEmailNotificationsToThings < ActiveRecord::Migration
  def change
    add_column :things, :email_notifications, :bool, :default => false
  end
end

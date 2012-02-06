class AddDefaultValuesToNotifications < ActiveRecord::Migration
  def change
    change_column :notifications, :email_sent, :boolean, :default => false
    change_column :notifications, :read, :boolean, :default => false
    
    Notification.update_all ["email_sent = ?, notifications.read = ?", false, false]

  end
end

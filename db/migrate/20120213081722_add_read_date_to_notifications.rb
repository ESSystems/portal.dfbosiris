class AddReadDateToNotifications < ActiveRecord::Migration
  def up
    add_column :notifications, :read_date, :timestamp
  end

  def down
    remove_column :notification, :read_date
  end
end

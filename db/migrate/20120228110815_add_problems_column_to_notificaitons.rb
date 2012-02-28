class AddProblemsColumnToNotificaitons < ActiveRecord::Migration
  def up
    add_column :notifications, :problems, :string
  end

  def down
    remove_column :notifications, :problems
  end
end

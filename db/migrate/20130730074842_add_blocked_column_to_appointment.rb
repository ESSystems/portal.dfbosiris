class AddBlockedColumnToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :blocked, :boolean
  end
end

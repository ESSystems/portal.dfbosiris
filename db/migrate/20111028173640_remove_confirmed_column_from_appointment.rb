class RemoveConfirmedColumnFromAppointment < ActiveRecord::Migration
  def change
    remove_column :appointments, :confirmed
  end
end

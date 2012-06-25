class DeletedAppointments < ActiveRecord::Migration
  def up
    add_column :appointments, :deleted_by, :int, :null => false
    add_column :appointments, :deleted_on, :datetime
    add_column :appointments, :deleted_reason, :string
  end

  def down
    remove_column :appointments, :deleted_by
    remove_column :appointments, :deleted_on
    remove_column :appointments, :deleted_reason
  end
end

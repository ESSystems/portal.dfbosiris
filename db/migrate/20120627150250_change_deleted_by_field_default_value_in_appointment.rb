class ChangeDeletedByFieldDefaultValueInAppointment < ActiveRecord::Migration
  def up
  	change_column :appointments, :deleted_by, :int, :null => true
  end

  def down
  	change_column :appointments, :deleted_by, :int, :null => false
  end
end

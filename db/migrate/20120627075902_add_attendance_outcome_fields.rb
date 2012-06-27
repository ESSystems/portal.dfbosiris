class AddAttendanceOutcomeFields < ActiveRecord::Migration
  def up
      add_column :attendances, :restrictions_applied, :boolean, :default => false
      add_column :attendances, :is_discharged, :boolean, :default => false
      add_column :attendances, :outcome_id, :int
  end

  def down
    remove_column :attendances, :restrictions_applied
    remove_column :attendances, :is_discharged
    remove_column :attendances, :outcome_id
  end
end

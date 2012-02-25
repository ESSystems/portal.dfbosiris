class AddDiaryReasonColumnToAttendanceReasons < ActiveRecord::Migration
  def up
    add_column :attendance_reasons, :diary_reason, :boolean, :default => 0
  end

  def down
    remove_column :attendance_reasons, :diary_reason
  end
end

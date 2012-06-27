class CreateAttendanceOutcomes < ActiveRecord::Migration
  def change
    create_table :attendance_outcomes do |t|
      t.string :title
    end
  end
end

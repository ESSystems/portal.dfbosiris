class CreateAttendanceFeedback < ActiveRecord::Migration
  def up
    create_table :attendance_feedback do |t|
        t.references :attendance
        t.text :report
        t.integer :created_by
        
        t.timestamps
      end
  end

  def down
    drop_table :attendance_feedback
  end
end

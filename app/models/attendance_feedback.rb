class AttendanceFeedback < ActiveRecord::Base
  set_table_name "attendance_feedback"
  
  belongs_to :attendance
end

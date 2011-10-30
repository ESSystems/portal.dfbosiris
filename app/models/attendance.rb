class Attendance < ActiveRecord::Base
  
  belongs_to :attendance_reason, :foreign_key => :attendance_reason_code
  belongs_to :attendance_result, :foreign_key => :attendance_result_code
  has_one :attendance_feedback
  
end

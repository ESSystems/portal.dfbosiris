class AttendanceFeedback < ActiveRecord::Base
  set_table_name "attendance_feedback"
  
  belongs_to :attendance
  
  has_many :documents, :as => :attachable
end

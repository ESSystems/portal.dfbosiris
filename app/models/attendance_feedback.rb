class AttendanceFeedback < ActiveRecord::Base
  self.table_name = "attendance_feedback"
  
  belongs_to :attendance
  
  has_many :documents, :as => :attachable
end

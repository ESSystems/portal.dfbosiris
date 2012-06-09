class AttendanceResult < ActiveRecord::Base
  self.primary_key = :code
  
  def to_s
    description
  end
end

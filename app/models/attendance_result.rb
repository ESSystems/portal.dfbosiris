class AttendanceResult < ActiveRecord::Base
  set_primary_key :code
  
  def to_s
    description
  end
end

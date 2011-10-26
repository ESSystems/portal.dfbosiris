class PatientStatus < ActiveRecord::Base
  
  def to_s
    status
  end
end

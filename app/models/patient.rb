class Patient < ActiveRecord::Base
  set_primary_key :PersonID
  
  def patient_id
    @PatientID
  end
end

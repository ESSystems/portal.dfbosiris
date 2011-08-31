class Patient < ActiveRecord::Base
  set_primary_key :PersonID
  
  belongs_to :person
  
  def patient_id
    @PatientID
  end
end

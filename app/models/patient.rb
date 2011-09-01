class Patient < ActiveRecord::Base
  set_primary_key :PersonID
  
  belongs_to :person, :foreign_key => :PersonID
  
  # def patient_id
  #   @PatientID
  # end
  
  def self.find_by_full_name(search)
    Person.autocomplete_fields.find_by_full_name search
  end
  
  def full_name
    person.full_name
  end
end

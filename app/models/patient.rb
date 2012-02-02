class Patient < ActiveRecord::Base
  set_primary_key :PersonID

  belongs_to :organisation, :foreign_key => :ResponsibleOrganisationID
  belongs_to :person, :foreign_key => :PersonID
  belongs_to :referrer, :class_name => 'User', :foreign_key => :referrer_id

  validates :organisation, :presence => true
  validates :person, :presence => true
  validates :referrer, :presence => true
  
  # def patient_id
    # @PatientID
  # end
  
  def self.find_by_full_name(search)
    Person.autocomplete_fields.find_by_full_name search
  end
  
  def full_name
    person.full_name
  end
  
  def organisation_id=(id)
    self.organisation = Organisation.find(id)
  end
end

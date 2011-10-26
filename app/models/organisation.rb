class Organisation < ActiveRecord::Base
  set_primary_key :OrganisationID
  
  def organisation_name
    self.OrganisationName
  end
  
  def organisation_name=(value)
    self.OrganisationName= value
  end
end
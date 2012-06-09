class Organisation < ActiveRecord::Base
  self.primary_key = :OrganisationID
  
  scope :order_by_name, lambda { |order|
    order("OrganisationName #{order}")
  }
  
  def organisation_name
    self.OrganisationName
  end
  
  def organisation_name=(value)
    self.OrganisationName= value
  end
  
  def to_s
    organisation_name
  end
end
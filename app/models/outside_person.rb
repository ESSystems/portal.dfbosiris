class OutsidePerson < ActiveRecord::Base
  
  belongs_to :organisation, :foreign_key => "client_id"
  belongs_to :person
  belongs_to :referrer, :class_name => 'User', :foreign_key => "referrer_id"

  validates :organisation, :presence => true
  validates :person, :presence => true
  validates :referrer, :presence => true
  
  def organisation_id=(id)
    self.organisation = Organisation.find(id)
  end
end

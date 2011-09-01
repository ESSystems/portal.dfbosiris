class Referral < ActiveRecord::Base
  belongs_to :person
  belongs_to :patient_status
  belongs_to :referral_reason
  
  validates :person, :presence => true
  validates :person_id, :presence => true
  validates :case_nature, :presence => true
  validates :referral_reason, :presence => true
  
  attr_accessor :person_full_name
end

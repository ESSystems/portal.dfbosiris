class Referral < ActiveRecord::Base
  belongs_to :patient
  belongs_to :patient_status
  belongs_to :referral_reason
  
  validates :patient, :presence => true
  validates :patient_id, :presence => true
  validates :case_nature, :presence => true
  validates :referral_reason, :presence => true
  
  attr_accessor :patient_full_name
end

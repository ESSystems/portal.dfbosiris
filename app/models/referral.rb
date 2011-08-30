class Referral < ActiveRecord::Base
  belongs_to :patient
  belongs_to :patient_status
  belongs_to :referral_reason
  
  validates_presence_of :case_nature, :referral_reason
end

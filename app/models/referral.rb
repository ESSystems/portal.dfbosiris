class Referral < ActiveRecord::Base
  attr_accessor :person_full_name
  attr_accessible :person, :person_id, :case_nature, :referral_reason, :referral_reason_id, :documents_attributes
  
  belongs_to :person
  belongs_to :patient_status
  belongs_to :referral_reason
  has_many :documents, :as => :attachable
  
  validates :person, :presence => true
  validates :person_id, :presence => true
  validates :case_nature, :presence => true
  validates :referral_reason, :presence => true
    
  accepts_nested_attributes_for :documents, :allow_destroy => true
end

class Referral < ActiveRecord::Base
  attr_accessor :person_full_name
  attr_accessible :person, :person_id, :patient_status, :patient_status_id, :patient_consent, :case_nature, :specific_requirements, :advice, :referral_reason, :referral_reason_id, :documents_attributes, :preferred_date
  
  belongs_to :person
  belongs_to :patient_status
  belongs_to :referral_reason
  has_many :documents, :as => :attachable, :dependent => :destroy
  has_one :appointment
  
  validates :person, :presence => true
  validates :patient_status, :presence => true
  validates :person_id, :presence => true
  validates :case_nature, :presence => true
  validates :referral_reason, :presence => true
  validates :case_reference_number, :presence => true
    
  accepts_nested_attributes_for :documents, :reject_if => lambda { |d| d[:document].blank? and d[:id] == "" }, :allow_destroy => true
  
  after_initialize :generate_case_reference_number
  
  def person_full_name
    person.full_name unless person.nil?
  end
  
  def show_patient_consent
    patient_consent ? "yes" : "no"
  end
  
  private 
  
  def generate_case_reference_number
    csn = SecureRandom.uuid
    csn.gsub!("-","")
    self.case_reference_number ||= csn[0..9].upcase
  end
  
  def valid_attribute?(attribute_name)
    self.valid?
    self.errors[attribute_name].blank?
  end
end

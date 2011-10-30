class Referral < ActiveRecord::Base
  
  STATE = %w[new accepted declined]
  
  attr_accessor :person_full_name
  attr_accessible :referrer_id, :person, :person_id, :patient_status, :patient_status_id, :patient_consent, :case_nature, :specific_requirements, :advice, :referral_reason, :referral_reason_id, :documents_attributes, :preferred_date, :follower_ids

  belongs_to :referrer, :class_name => 'User', :foreign_key => "referrer_id"
  belongs_to :person
  belongs_to :patient_status
  belongs_to :referral_reason
  has_many :documents, :as => :attachable, :dependent => :destroy
  has_one :appointment
  has_and_belongs_to_many :followers, :class_name => 'User', :join_table => 'referrals_followers', :association_foreign_key => "referrer_id", :autosave => true
  has_one :declination

  validates :referrer, :presence => true
  validates :person, :presence => true
  validates :patient_status, :presence => true
  validates :person_id, :presence => true
  validates :case_nature, :presence => true
  validates :referral_reason, :presence => true
  validates :case_reference_number, :presence => true

  accepts_nested_attributes_for :documents, :reject_if => lambda { |d| d[:document].blank? and d[:id] == "" }, :allow_destroy => true

  after_initialize :generate_case_reference_number
  
  scope :initiated, lambda { |referrer_id|
    where("referrals.referrer_id" => referrer_id)
  }
  
  scope :assigned, lambda { |referrer_id|
    joins(:followers).where("referrals_followers.referrer_id" => referrer_id)
  }
  
  scope :initiated_and_assigned, lambda { |referrer_id|
    initiated(referrer_id) | assigned(referrer_id)
  }

  def person_full_name
    person.full_name unless person.nil?
  end

  def show_patient_consent
    patient_consent ? "yes" : "no"
  end

  def short_case_nature
    cn = case_nature.slice(0..150)
    cn << "..." if case_nature.length > 150
    cn
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

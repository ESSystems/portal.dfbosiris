class Referral < ActiveRecord::Base
  
  STATE = %w[new accepted declined closed]
  
  attr_accessor :person_full_name
  attr_accessible :referrer_id, :person, :person_id, :patient_status, :patient_status_id, 
                  :case_nature, :job_information, :history, :referral_reason, :referral_reason_id, :documents_attributes, 
                  :operational_priority, :operational_priority_id, :follower_ids, :sickness_started, :sicknote_expires

  belongs_to :referrer, :class_name => 'User', :foreign_key => "referrer_id"
  belongs_to :person
  belongs_to :patient_status
  belongs_to :referral_reason
  belongs_to :operational_priority
  has_many :documents, :as => :attachable, :dependent => :destroy
  has_many :appointments
  has_and_belongs_to_many :followers, :class_name => 'User', :join_table => 'referrals_followers', :association_foreign_key => "referrer_id", :autosave => true
  has_many :declinations

  validates :referrer, :presence => true
  validates :person, :presence => true
  validates :patient_status, :presence => true
  validates :job_information, :presence => true
  validates :person_id, :presence => true
  validates :case_nature, :presence => true
  validates :history, :presence => true
  validates :referral_reason, :presence => true
  validates :operational_priority, :presence => true
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
  
  scope :referrals_in_organisation, lambda { |organisation_id|
    joins(:referrer).where("referrers.client_id" => organisation_id)
  }
  
  scope :search, lambda { |query|
    param = "%#{query.strip}%"
    query_string = <<-eos
      person.first_name LIKE ? OR person.last_name LIKE ? 
      OR referral_reasons.reason LIKE ? 
      OR case_reference_number LIKE ? 
      OR case_nature LIKE ?
    eos

    joins(:person).joins(:referral_reason).where(
      query_string,
      param, param,
      param,
      param,
      param
    )
  }

  #default_scope order("created_at DESC")

  def person_full_name
    person.full_name unless person.nil?
  end

  def short_case_nature
    cn = case_nature.slice(0..150)
    cn << "..." if case_nature.length > 150
    cn
  end
  
  def appointment
    appointments.first
  end
  
  def close
    update_attribute(:state, :closed)
  end
  
  def closed?
    state == "closed"
  end
  
  def declined?
    state == "declined"
  end
  
  def decline
    self.state = "declined"
  end
  
  def renew
    self.state = "new"
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

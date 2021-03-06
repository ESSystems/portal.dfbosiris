class Person < ActiveRecord::Base

  self.table_name = "person"

  default_scope order("last_name")

  has_one :patient, :foreign_key => :PersonID
  has_one :employee
  has_one :referrer, :through => :patient

  scope :employees_in_organisation, lambda { |organisation_id|
    joins(:employee).where("nemployees.client_id = ? and nemployees.employment_end_date IS NULL", organisation_id)
  }

  scope :find_by_full_name, lambda { |search|
    split_search = search.split(' ')
    logger.debug "Split search full name size: #{split_search.length}"
    if split_search.length == 1
      param = "#{search.strip}%"
      where("person.first_name LIKE ? OR person.last_name LIKE ?", param, param)
    else
      where("person.first_name LIKE ? AND person.last_name LIKE ? OR person.first_name LIKE ? AND person.last_name LIKE ?",
        "#{split_search[0]}%", "#{split_search[1]}%",
        "#{split_search[1]}%", "#{split_search[0]}%")
    end
  }

  def self.find_people_in_organisation_by_full_name organisation_id, search, limit
    employees = find_by_full_name(search).joins(:employee).where("nemployees.client_id = ? AND nemployees.employment_end_date IS NULL AND nemployees.id = (SELECT MAX(id) FROM nemployees WHERE person_id = person.id)", organisation_id).order("last_name ASC").limit(limit)
    outside_patients = find_by_full_name(search).joins(:patient).joins(:referrer).where("referrers.client_id" => organisation_id).order("last_name ASC").limit(limit)
    employees.concat(outside_patients)
  end

  # returns people added by referrers in organisation
  scope :outside_people_in_organisation, lambda {|organisation_id|
    joins(:patient).joins(:referrer).where("referrers.client_id" => organisation_id)
  }

  scope :people_in_organisation, lambda { |organisation_id|
    employees_in_organisation(organisation_id) | outside_people_in_organisation(organisation_id)
  }

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  accepts_nested_attributes_for :patient

  def add_outside_person(current_user)
    self.added_by_referrer = true
    self.patient.person = self
    self.patient.referrer = current_user
  end

  def full_name
    [first_name, middle_name_with_period, last_name].compact.join(' ')
  end

  def full_name=(full_name)
    full_name_array = full_name.split
    case full_name_array.count
    when 1
      self.first_name = full_name_array[0]
      self.middle_name = nil
      self.last_name = nil
    when 2
      self.first_name = full_name_array[0]
      self.middle_name = nil
      self.last_name = full_name_array[1]
    when 3
      self.first_name = full_name_array[0]
      self.middle_name = full_name_array[1]
      self.last_name = full_name_array[2]
    end
  end

  def middle_name_with_period
    (middle_name[-1,1] != "." ? middle_name << '.' : middle_name) unless middle_name.blank?
  end

  def first_name
    super.capitalize unless super == nil
  end

  def last_name
    super.capitalize unless super == nil
  end

  def middle_name
    super.capitalize unless super == nil
  end
end

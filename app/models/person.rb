class Person < ActiveRecord::Base
  set_table_name "person"
  
  has_one :patient
  has_one :employee
  has_one :outside_person
  has_one :referrer, :through => :outside_person
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  
  scope :find_by_full_name, lambda { |search| 
    param = "%#{search}%"
    where("first_name LIKE ? OR last_name LIKE ?", param, param)
  }
  
  scope :people_in_organisation, lambda { |organisation_id|
    joins(:employee).where("nemployees.client_id" => organisation_id) | 
    joins(:outside_person).where("outside_people.client_id" => organisation_id)
  }
  
  def add_outside_person(current_user)
    OutsidePerson.create(:person => self, :referrer => current_user, :organisation_id => current_user.client_id)
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

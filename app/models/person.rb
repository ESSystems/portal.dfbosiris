class Person < ActiveRecord::Base
  set_table_name "person"
  
  has_one :patient
  
  scope :autocomplete_fields, select("id, CONCAT(first_name,' ',last_name) as label, CONCAT(first_name,' ',last_name) as value")
  scope :find_by_full_name, lambda { |search| 
    param = "%#{search}%"
    where("first_name LIKE ? OR last_name LIKE ?", param, param) 
  }
    
  def full_name
    [first_name, middle_name_with_period, last_name].compact.join(' ')
  end
  
  def middle_name_with_period
    (middle_name[-1,1] != "." ? middle_name << '.' : middle_name) unless middle_name.blank?
  end
  
  def first_name
    super.capitalize
  end
  
  def last_name
    super.capitalize
  end
  
  def middle_name
    super.capitalize
  end
  
end

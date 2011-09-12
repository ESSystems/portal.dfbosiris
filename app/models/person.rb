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

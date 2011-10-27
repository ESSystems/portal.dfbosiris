class Department < ActiveRecord::Base
  set_primary_key :DepartmentCode
  
  def to_s
    self.DepartmentDescription
  end
end

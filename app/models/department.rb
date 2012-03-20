class Department < ActiveRecord::Base
  set_primary_key :DepartmentCode
  
  def self.get_name person_id
    name = Department.find_by_sql ["SELECT d.DepartmentDescription FROM departments AS d JOIN nemployees AS e WHERE e.department_id = d.DepartmentCode and e.person_id = ?", person_id] if person_id
    name.first if name
  end

  def to_s
    self.DepartmentDescription
  end
end

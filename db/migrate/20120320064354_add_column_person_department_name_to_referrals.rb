class AddColumnPersonDepartmentNameToReferrals < ActiveRecord::Migration
  def up
    add_column :referrals, :person_department_name, :string, :limit => 100
  end

  def down
    remove_column :referrals, :person_department_name
  end
end

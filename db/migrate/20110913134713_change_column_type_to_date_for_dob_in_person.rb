class ChangeColumnTypeToDateForDobInPerson < ActiveRecord::Migration
  def up
    change_column(:person, :date_of_birth, :date) 
  end

end

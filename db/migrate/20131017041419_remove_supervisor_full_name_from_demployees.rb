class RemoveSupervisorFullNameFromDemployees < ActiveRecord::Migration
  def up
    remove_column :demployees, :supervisor_full_name
  end

  def down
    add_column :demployees, :supervisor_full_name, :string
  end
end

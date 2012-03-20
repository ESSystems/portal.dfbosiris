class AddReferrerNameColumnToAppointments < ActiveRecord::Migration
  def up
    add_column :appointments, :referrer_name, :string, :limit => 100
  end

  def down
    remove_column :appointments, :referrer_name
  end
end

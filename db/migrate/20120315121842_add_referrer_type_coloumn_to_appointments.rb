class AddReferrerTypeColoumnToAppointments < ActiveRecord::Migration
    def up
    add_column :appointments, :referrer_type_id, :integer
  end

  def down
    remove_column :appointments, :referrer_type_id
  end
end

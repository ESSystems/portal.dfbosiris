class UsePersonInsteadOfPatientForReferrals < ActiveRecord::Migration
  def up
    rename_column :referrals, :patient_id, :person_id
  end

  def down
  end
end

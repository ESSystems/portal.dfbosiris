class RemovePatientConsentFromReferral < ActiveRecord::Migration
  def change
    remove_column :referrals, :patient_consent
  end
end

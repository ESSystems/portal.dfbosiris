class CreateReferrals < ActiveRecord::Migration
  def change
      create_table :referrals do |t|
        t.references :patient
        t.references :patient_status
        t.text :case_nature
        t.text :specific_requirements
        t.text :advice
        t.references :referral_reason
        t.datetime :preferred_date
        t.boolean :patient_consent

        t.timestamps
      end
    end
end
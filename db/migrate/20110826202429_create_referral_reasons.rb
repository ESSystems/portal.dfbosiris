class CreateReferralReasons < ActiveRecord::Migration
  def change
    create_table :referral_reasons do |t|
      t.string :reason

      t.timestamps
    end
  end
end

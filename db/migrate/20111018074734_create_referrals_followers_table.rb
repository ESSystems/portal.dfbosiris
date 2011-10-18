class CreateReferralsFollowersTable < ActiveRecord::Migration
  def up
    create_table :referrals_followers do |t|
        t.references :referral
        t.references :referrer
      end
  end
end

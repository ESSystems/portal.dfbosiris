class AddTrackReferralsColumnToReferrers < ActiveRecord::Migration
  def change
    add_column :referrers, :track_referrals, :string
  end
end

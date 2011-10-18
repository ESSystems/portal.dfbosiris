class AddReferrerColumnToReferral < ActiveRecord::Migration
  def change
    add_column :referrals, :referrer_id, :integer
  end
end

class AddCanceledColumnsToReferrals < ActiveRecord::Migration
  def up
    add_column :referrals, :canceled_on, :datetime
    add_column :referrals, :canceled_reason, :string
  end

  def down
    remove_column :referrals, :canceled_on
    remove_column :referrals, :canceled_reason
  end
end

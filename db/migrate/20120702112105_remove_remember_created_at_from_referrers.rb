class RemoveRememberCreatedAtFromReferrers < ActiveRecord::Migration
  def up
  	remove_column :referrers, :remember_created_at
  end

  def down
  	add_column :referrers, :remember_created_at, :datetime
  end
end

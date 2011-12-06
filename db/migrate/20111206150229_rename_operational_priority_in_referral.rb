class RenameOperationalPriorityInReferral < ActiveRecord::Migration
  def change
    rename_column :referrals, :operational_priority, :operational_priority_id
  end
end

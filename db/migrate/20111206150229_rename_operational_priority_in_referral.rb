class RenameOperationalPriorityInReferral < ActiveRecord::Migration
  def change
    rename_column :referrals, :operational_prioirty, :operational_priority_id
  end
end

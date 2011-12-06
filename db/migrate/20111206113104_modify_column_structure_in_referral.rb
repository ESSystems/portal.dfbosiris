class ModifyColumnStructureInReferral < ActiveRecord::Migration
  def change
    remove_column :referrals, :preferred_date
    
    add_column :referrals, :sickness_started, :date
    add_column :referrals, :sicknote_expires, :date
    add_column :referrals, :operational_prioirty, :string
  end
end

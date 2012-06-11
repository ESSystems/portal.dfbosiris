class AddPrivateFieldToReferral < ActiveRecord::Migration
  def up
  	change_table :referrals do |t|
      t.boolean :private, :default => false
    end
  end

  def down
  	remove_column :referrals, :private
  end
end

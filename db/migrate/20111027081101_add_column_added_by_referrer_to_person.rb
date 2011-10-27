class AddColumnAddedByReferrerToPerson < ActiveRecord::Migration
  def up
    add_column :person, :added_by_referrer, :boolean, :default => 0
  end

  def down
    remove_column :person, :added_by_referrer
  end
end

class AddUniqueIndexToUsernameColumnInReferrals < ActiveRecord::Migration
  def change
    add_index :referrers, :username, :unique => true
  end
end

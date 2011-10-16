class AddUsernameColumnToReferrers < ActiveRecord::Migration
  def change
    add_column :referrers, :username, :string
  end
end

class ChangeReferrerEmailNull < ActiveRecord::Migration
  def up
    change_column :referrers, :email, :string, :null => true
  end

  def down
    change_column :referrers, :email, :string, :null => false
  end
end

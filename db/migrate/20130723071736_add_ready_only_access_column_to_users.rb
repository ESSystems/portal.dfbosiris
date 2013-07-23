class AddReadyOnlyAccessColumnToUsers < ActiveRecord::Migration
  def change
    add_column :referrers, :read_only_access, :boolean
  end
end

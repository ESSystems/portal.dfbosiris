class AddReferrerTypeColoumnToReferrers < ActiveRecord::Migration
  def up
    add_column :referrers, :referrer_type_id, :integer
  end

  def down
    remove_column :referrers, :referrer_type_id
  end
end

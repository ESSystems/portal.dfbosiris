class AddReferrerIdColumnToPatient < ActiveRecord::Migration
  def up
    add_column :patients, :referrer_id, :integer
  end

  def down
    remove_column :patients, :referrer_id
  end
end

class AddClientColumnToReferrer < ActiveRecord::Migration
  def change
    add_column :referrers, :client_id, :integer
  end
end

class AddOriginFieldToDocument < ActiveRecord::Migration
  def up
  	add_column :documents, :origin, :string
  end

  def down
  	remove_column :documents, :origin
  end
end

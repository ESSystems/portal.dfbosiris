class AddIndexesToPerson < ActiveRecord::Migration
  def up
  	add_index :person, :first_name
  	add_index :person, :last_name
  	add_index :person, [:first_name, :last_name]
  end

  def down
  	remove_index :person, :first_name
  	remove_index :person, :last_name
  	remove_index :person, [:first_name, :last_name]
  end
end

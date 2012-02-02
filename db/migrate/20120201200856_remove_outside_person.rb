class RemoveOutsidePerson < ActiveRecord::Migration
  def change
    drop_table :outside_people
  end
end

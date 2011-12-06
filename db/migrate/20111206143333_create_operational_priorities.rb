class CreateOperationalPriorities < ActiveRecord::Migration
  def up
    create_table :operational_priorities do |t|
        t.string :operational_priority
        
        t.timestamps
      end
  end

  def down
    drop_table :operational_priorities
  end
end

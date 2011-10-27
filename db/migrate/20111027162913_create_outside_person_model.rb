class CreateOutsidePersonModel < ActiveRecord::Migration
  def up
    create_table :outside_people do |t|
        t.references :client
        t.references :person
        t.references :referrer
        
        t.timestamps
      end
  end

  def down
    drop_table :outside_people
  end
end

class CreateReferrerTypes < ActiveRecord::Migration
  def up
    create_table :referrer_types do |rt|
      rt.string :type
      
      rt.timestamps
    end
  end

  def down
    drop_table :referrer_types
  end
end

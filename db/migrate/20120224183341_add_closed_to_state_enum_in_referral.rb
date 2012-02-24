class AddClosedToStateEnumInReferral < ActiveRecord::Migration
  def change
    execute <<-SQL
      ALTER TABLE `referrals` 
        CHANGE COLUMN `state` `state` ENUM('new','accepted','declined','closed') 
        NOT NULL DEFAULT 'new'
    SQL
  end
end

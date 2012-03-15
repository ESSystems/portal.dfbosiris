class AddNewOrReviewColumnToAppointments < ActiveRecord::Migration
  def up
    add_column :appointments, :new_or_review, :string, :limit => 10
  end

  def down
    remove_column :appointments, :new_or_review
  end
end

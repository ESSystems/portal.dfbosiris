class GetRidOfEnums < ActiveRecord::Migration
  def up
    change_column :appointments, :state, :string, :limit => 16
    change_column :attendances, :work_related_absence, :string, :limit => 1
    change_column :attendances, :review_attendance, :string, :limit => 1
    change_column :attendances, :work_discomfort, :string, :limit => 1
    change_column :attendances, :accident_report_complete, :string, :limit => 1
    change_column :attendances, :no_work_contact, :string, :limit => 1
    change_column :followups, :type, :string, :limit => 8
    
    change_column :recall_list_item_events, :contact_type, :string, :limit => 64
    change_column :referrals, :state, :string, :limit => 16
  end

  def down
  end
end

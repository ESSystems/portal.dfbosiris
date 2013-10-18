class MovetoDfbDatabase < ActiveRecord::Migration
  def up
    drop_table :nemployees

    create_table :demployees do |t|
      t.integer  "person_id",               :null => false
      t.integer  "client_id",               :null => false
      t.string   "payroll_number"
      t.date     "employment_start_date"
      t.date     "employment_end_date"
      t.string   "department_id",           :limit => 32,      :null => false
      t.string   "current_department_code", :limit => 32
      t.string   "job_class_id",            :limit => 8,       :null => false
      t.datetime "created"
      t.datetime "modified"
      t.boolean  "is_obsolete",             :default => false, :null => false
      t.integer  "import_id"
      t.string   "work_schedule_rule",      :limit => 64
      t.string   "supervisor_full_name"
      t.string   "occupancy_status",        :limit => 32
    end

    add_index :demployees, :person_id
    add_index :demployees, :client_id

    u = Organisation.find 1
    u.update_attribute :OrganisationName, "Durham Fire Brigade"

    c = Clinic.find 1
    c.update_attribute :clinic_name, "Durham Fire Brigade"

    ActiveRecord::Base.connection.execute("TRUNCATE appointments")
    ActiveRecord::Base.connection.execute("TRUNCATE attendance_feedback")
    ActiveRecord::Base.connection.execute("TRUNCATE absences")
    ActiveRecord::Base.connection.execute("TRUNCATE attendances")
    ActiveRecord::Base.connection.execute("TRUNCATE departments")
    ActiveRecord::Base.connection.execute("TRUNCATE documents")
    ActiveRecord::Base.connection.execute("TRUNCATE job_classes")
    ActiveRecord::Base.connection.execute("TRUNCATE notifications")
    ActiveRecord::Base.connection.execute("TRUNCATE patients")
    ActiveRecord::Base.connection.execute("DELETE FROM person WHERE id NOT IN (SELECT id FROM clinic_staff_member);")
    ActiveRecord::Base.connection.execute("TRUNCATE recall_list_item_events")
    ActiveRecord::Base.connection.execute("TRUNCATE recall_list_items")
    ActiveRecord::Base.connection.execute("TRUNCATE referrals")
    ActiveRecord::Base.connection.execute("TRUNCATE referrals_followers")
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't go back to Nissan schema"
  end
end
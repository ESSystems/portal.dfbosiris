# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110831125841) do

  create_table "absences", :force => true do |t|
    t.integer  "person_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "returned_to_work_date"
    t.float    "sick_days"
    t.string   "work_related_absence",        :limit => 1
    t.string   "accident_report_completed",   :limit => 1
    t.string   "discomfort_report_completed", :limit => 1
    t.string   "tickbox_neither",             :limit => 1
    t.string   "department_code",             :limit => 20
    t.string   "main_diagnosis_code",         :limit => 12
    t.datetime "created"
    t.integer  "employee_id"
  end

  add_index "absences", ["person_id"], :name => "person_id"

  create_table "appointments", :force => true do |t|
    t.string   "type",          :limit => 8
    t.integer  "user_id",                    :null => false
    t.integer  "diary_id",                   :null => false
    t.integer  "person_id",                  :null => false
    t.datetime "from_date"
    t.datetime "to_date"
    t.text     "note"
    t.datetime "created"
    t.datetime "modified"
    t.integer  "attendance_id"
  end

  create_table "attendance_reasons", :primary_key => "code", :force => true do |t|
    t.string "description", :limit => 100, :null => false
  end

  create_table "attendance_results", :primary_key => "code", :force => true do |t|
    t.string "description", :limit => 100, :null => false
  end

  create_table "attendancediagnosis", :primary_key => "AttendanceID", :force => true do |t|
    t.string "DiagnosisCode", :limit => 12
  end

  create_table "attendances", :force => true do |t|
    t.integer  "person_id"
    t.datetime "attendance_date_time"
    t.integer  "clinic_id"
    t.string   "attendance_reason_code",   :limit => 8
    t.string   "attendance_result_code",   :limit => 8
    t.text     "comments",                 :limit => 255
    t.integer  "clinic_staff_id"
    t.datetime "seen_at_time"
    t.integer  "diary_entry_id"
    t.string   "work_related_absence",     :limit => 0,   :default => "N"
    t.string   "review_attendance",        :limit => 0,   :default => "N"
    t.string   "transport_type_code",      :limit => 8
    t.string   "work_discomfort",          :limit => 0,   :default => "N"
    t.string   "accident_report_complete", :limit => 0,   :default => "N"
    t.float    "contact_id"
    t.datetime "attendance_time"
    t.string   "diagnosis_id",             :limit => 16,                     :null => false
    t.integer  "employee_id"
    t.integer  "recall_event_id"
    t.boolean  "is_hidden",                               :default => false, :null => false
    t.string   "no_work_contact",          :limit => 0,   :default => "N"
  end

  create_table "client", :primary_key => "ClientID", :force => true do |t|
    t.string  "ClientName",          :limit => 40
    t.string  "BillingAddressLine1", :limit => 40
    t.string  "BillingAddressLine2", :limit => 40
    t.string  "BillingAddressLine3", :limit => 40
    t.string  "BillingCounty",       :limit => 40
    t.string  "BillingPostCode",     :limit => 16
    t.integer "WorkDaysPerWeek"
  end

  create_table "client_employee", :primary_key => "person_id", :force => true do |t|
    t.integer  "salary_number"
    t.integer  "sap_number"
    t.integer  "Supervisor"
    t.integer  "client_id",                             :null => false
    t.datetime "employment_start_date"
    t.datetime "employment_end_date"
    t.string   "current_department_code", :limit => 32, :null => false
  end

  add_index "client_employee", ["Supervisor"], :name => "Supervisor"
  add_index "client_employee", ["salary_number"], :name => "salary_number"

  create_table "clinic", :force => true do |t|
    t.string "clinic_name",        :limit => 80
    t.string "physical_line1",     :limit => 40
    t.string "physical_line2",     :limit => 40
    t.string "physical_line3",     :limit => 40
    t.string "physical_county",    :limit => 40
    t.string "physical_post_code", :limit => 16
    t.string "postal_line1",       :limit => 40
    t.string "postal_line2",       :limit => 40
    t.string "postal_line3",       :limit => 40
    t.string "postal_county",      :limit => 40
    t.string "postal_post_code",   :limit => 16
    t.string "area_code",          :limit => 12
    t.string "telephone_number",   :limit => 22
    t.string "ExtensionNumber",    :limit => 10
  end

  create_table "clinic_staff_member", :force => true do |t|
    t.integer "diary_id"
    t.integer "security_id"
    t.float   "clinic_department_id"
    t.integer "clinic_id"
    t.string  "sec_status_code",      :limit => 2
    t.string  "sec_password",         :limit => 30
  end

  create_table "departments", :primary_key => "DepartmentCode", :force => true do |t|
    t.integer "ClientID"
    t.string  "DepartmentDescription",    :limit => 100
    t.integer "RecallAbsenceDayQuantity"
  end

  create_table "diagnoses", :force => true do |t|
    t.integer "parent_id",                  :null => false
    t.string  "_id",         :limit => 12,  :null => false
    t.string  "_parent_id",  :limit => 12,  :null => false
    t.string  "description", :limit => 150, :null => false
    t.string  "is_obsolete", :limit => 2,   :null => false
  end

  create_table "diagnoses_sicknotes", :id => false, :force => true do |t|
    t.integer "sicknote_id",                  :null => false
    t.string  "diagnosis_code", :limit => 12, :null => false
  end

  add_index "diagnoses_sicknotes", ["diagnosis_code"], :name => "diagnosis_code"
  add_index "diagnoses_sicknotes", ["sicknote_id"], :name => "sicknote_id"

  create_table "diaries", :force => true do |t|
    t.string   "name",                                  :null => false
    t.integer  "owner_id",                              :null => false
    t.integer  "color_id",                              :null => false
    t.time     "start_time",                            :null => false
    t.time     "end_time",                              :null => false
    t.integer  "appointment_length",                    :null => false
    t.integer  "available_days",           :limit => 2, :null => false
    t.string   "default_appointment_type", :limit => 8
    t.datetime "created"
    t.datetime "modified"
  end

  create_table "diary_restrictions", :force => true do |t|
    t.integer  "diary_id",                                                  :null => false
    t.string   "title",                                                     :null => false
    t.time     "from_time",              :default => '2000-01-01 00:00:00', :null => false
    t.time     "to_time",                :default => '2000-01-01 23:59:59', :null => false
    t.date     "from_date"
    t.date     "to_date"
    t.integer  "week_day",  :limit => 1, :default => 0,                     :null => false
    t.integer  "month_day",              :default => 0,                     :null => false
    t.integer  "month",     :limit => 2, :default => 0,                     :null => false
    t.datetime "created"
    t.datetime "modified"
  end

  create_table "employee_department", :primary_key => "person_id", :force => true do |t|
    t.integer  "client_id",                     :null => false
    t.string   "department_code", :limit => 32
    t.datetime "from_date"
    t.date     "to_date"
  end

  create_table "employee_job_class", :primary_key => "person_id", :force => true do |t|
    t.integer  "client_id",                   :null => false
    t.string   "job_class_code", :limit => 8
    t.datetime "from_date"
    t.date     "to_date"
  end

  create_table "followups", :force => true do |t|
    t.integer  "attendance_id",                     :null => false
    t.integer  "result_attendance_id"
    t.integer  "person_id",                         :null => false
    t.string   "type",                 :limit => 0, :null => false
    t.datetime "date"
    t.datetime "created"
  end

  create_table "job_classes", :primary_key => "JobClassCode", :force => true do |t|
    t.integer "ClientID"
    t.string  "JobClassDescription", :limit => 100
    t.string  "IOHJobClassCode",     :limit => 20
  end

  create_table "nemployees", :force => true do |t|
    t.integer  "person_id",                                                :null => false
    t.integer  "client_id",                                                :null => false
    t.integer  "salary_number"
    t.integer  "sap_number"
    t.integer  "supervisor_id"
    t.integer  "sup_salary_number"
    t.integer  "sup_sap_number"
    t.date     "employment_start_date"
    t.date     "employment_end_date"
    t.string   "department_id",           :limit => 32,                    :null => false
    t.string   "current_department_code", :limit => 32
    t.string   "job_class_id",            :limit => 8,                     :null => false
    t.datetime "created"
    t.datetime "modified"
    t.boolean  "is_obsolete",                           :default => false, :null => false
    t.integer  "import_id"
    t.string   "work_schedule_rule",      :limit => 64
  end

  add_index "nemployees", ["person_id"], :name => "person_id"
  add_index "nemployees", ["salary_number"], :name => "salary_number"
  add_index "nemployees", ["sap_number"], :name => "sap_number"
  add_index "nemployees", ["sup_salary_number"], :name => "sup_salary_number"
  add_index "nemployees", ["sup_sap_number"], :name => "sup_sap_number"
  add_index "nemployees", ["sup_sap_number"], :name => "sup_sap_number_2"

  create_table "organisations", :primary_key => "OrganisationID", :force => true do |t|
    t.string "OrganisationName",     :limit => 80
    t.string "PhysicalAddressLine1", :limit => 40
    t.string "PhysicalAddressLine2", :limit => 40
    t.string "PhysicalAddressLine3", :limit => 40
    t.string "PhysicalCounty",       :limit => 40
    t.string "PhysicalPostCode",     :limit => 16
    t.string "IsClient",             :limit => 1
  end

  create_table "patient_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :primary_key => "PersonID", :force => true do |t|
    t.string  "IsEmployee",                :limit => 1
    t.integer "ResponsibleOrganisationID",              :default => 0, :null => false
    t.integer "CLIENT_CONTACT_PERSON_ID"
  end

  create_table "person", :force => true do |t|
    t.string   "first_name",       :limit => 60
    t.string   "last_name",        :limit => 40
    t.string   "middle_name",      :limit => 10
    t.string   "title",            :limit => 12
    t.datetime "date_of_birth"
    t.string   "address1",         :limit => 100
    t.string   "address2",         :limit => 100
    t.string   "address3",         :limit => 100
    t.string   "county",           :limit => 100
    t.string   "post_code",        :limit => 20
    t.string   "area_code",        :limit => 20
    t.string   "telephone_number", :limit => 40
    t.string   "extension",        :limit => 10
    t.string   "gender",           :limit => 2
    t.string   "email_address",    :limit => 100
  end

  create_table "recall_list_item_events", :force => true do |t|
    t.integer  "recall_list_item_id",                                                 :null => false
    t.datetime "due_date"
    t.integer  "call_no",                          :default => 1,                     :null => false
    t.datetime "attended_date"
    t.integer  "attendance_id"
    t.text     "note"
    t.datetime "created"
    t.string   "contact_type",        :limit => 0, :default => "Advised by OH Staff"
    t.integer  "created_by",                                                          :null => false
    t.date     "invite_date",                                                         :null => false
    t.text     "comments",                                                            :null => false
  end

  create_table "recall_list_items", :force => true do |t|
    t.integer  "recall_list_id",     :null => false
    t.integer  "employee_id"
    t.integer  "person_id",          :null => false
    t.datetime "last_attended_date"
    t.datetime "created"
    t.datetime "modified"
  end

  add_index "recall_list_items", ["employee_id"], :name => "employee_id"
  add_index "recall_list_items", ["recall_list_id", "person_id"], :name => "recall_list_id_2"
  add_index "recall_list_items", ["recall_list_id"], :name => "recall_list_id"

  create_table "recall_lists", :force => true do |t|
    t.string   "title",                  :null => false
    t.integer  "recall_list_item_count", :null => false
    t.datetime "created"
    t.datetime "modified"
  end

  create_table "referral_reasons", :force => true do |t|
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referrals", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "patient_status_id"
    t.text     "case_nature"
    t.text     "specific_requirements"
    t.text     "advice"
    t.integer  "referral_reason_id"
    t.datetime "preferred_date"
    t.boolean  "patient_consent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sec_category", :force => true do |t|
    t.string "category_name", :limit => 100, :null => false
  end

  create_table "sec_function", :force => true do |t|
    t.string  "function_name", :limit => 100, :null => false
    t.string  "status_code",   :limit => 2
    t.integer "category_id"
  end

  create_table "sec_group", :force => true do |t|
    t.string "group_name",  :limit => 100, :null => false
    t.string "status_code", :limit => 2
  end

  create_table "sec_group_function", :id => false, :force => true do |t|
    t.integer "group_id",    :null => false
    t.integer "function_id", :null => false
  end

  create_table "sec_status", :primary_key => "status_code", :force => true do |t|
    t.string "status_description", :limit => 40
  end

  create_table "sec_user_function", :id => false, :force => true do |t|
    t.integer "user_id",     :default => 0, :null => false
    t.integer "function_id", :default => 0, :null => false
  end

  create_table "sec_user_group", :id => false, :force => true do |t|
    t.integer "user_id",  :default => 0, :null => false
    t.integer "group_id", :default => 0, :null => false
  end

  create_table "sicknote_types", :primary_key => "code", :force => true do |t|
    t.string "description", :limit => 100, :null => false
  end

  create_table "sicknotes", :force => true do |t|
    t.string   "type_code",            :limit => 8,                  :null => false
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "symptoms_description", :limit => 255
    t.text     "comments",             :limit => 255
    t.datetime "created"
    t.integer  "absence_id",                                         :null => false
    t.integer  "sick_days",                           :default => 0, :null => false
  end

  add_index "sicknotes", ["absence_id"], :name => "AbsenceID"

end

class AddIndexesToTables < ActiveRecord::Migration
  def up
  	add_index :appointments, :referral_id
  	add_index :appointments, :person_id
  	add_index :appointments, :referral_reason_id
  	add_index :appointments, :diary_id
  	add_index :appointments, :attendance_id
    add_index :appointments, [:from_date, :to_date, :diary_id], :name => 'diary_id_to_date_from_date_index'

    add_index :attendances, :attendance_reason_code
    add_index :attendances, :attendance_result_code

    add_index :attendance_feedback, :attendance_id

    add_index :declinations, :referral_id
    add_index :declinations, :created_by

    add_index :documents, [:attachable_id, :attachable_type]

    add_index :nemployees, :client_id
    add_index :nemployees, :department_id
    add_index :nemployees, :job_class_id

    add_index :notifications, [:target_id, :target_model], :name => 'target_id_target_model_index'
    add_index :notifications, [:target_id, :read], :name => 'read_target_id_index'

  	add_index :patients, :ResponsibleOrganisationID
  	add_index :patients, :PersonID
  	add_index :patients, :referrer_id

    add_index :referrals, :referrer_id
    add_index :referrals, :person_id
    add_index :referrals, :patient_status_id
    add_index :referrals, :referral_reason_id
    add_index :referrals, :operational_priority_id

    add_index :referrals_followers, :referrer_id
    add_index :referrals_followers, :referral_id

    add_index :referrers, :person_id
    add_index :referrers, :client_id
    add_index :referrers, :referrer_type_id
  end

  def down
    remove_index :appointments, :referral_id
    remove_index :appointments, :person_id
    remove_index :appointments, :referral_reason_id
    remove_index :appointments, :diary_id
    remove_index :appointments, :attendance_id
    remove_index :appointments, :name => 'diary_id_to_date_from_date_index'

    remove_index :attendances, :attendance_reason_code
    remove_index :attendances, :attendance_result_code

    remove_index :attendance_feedback, :attendance_id

    remove_index :declinations, :referral_id
    remove_index :declinations, :created_by

    remove_index :documents, [:attachable_id, :attachable_type]

    remove_index :nemployees, :client_id
    remove_index :nemployees, :department_id
    remove_index :nemployees, :job_class_id

    remove_index :notifications, :name => 'target_id_target_model_index'
    remove_index :notifications, :name => 'read_target_id_index'

    remove_index :patients, :ResponsibleOrganisationID
    remove_index :patients, :PersonID
    remove_index :patients, :referrer_id

    remove_index :referrals, :referrer_id
    remove_index :referrals, :person_id
    remove_index :referrals, :patient_status_id
    remove_index :referrals, :referral_reason_id
    remove_index :referrals, :operational_priority_id

    remove_index :referrals_followers, :referrer_id
    remove_index :referrals_followers, :referral_id

    remove_index :referrers, :person_id
    remove_index :referrers, :client_id
    remove_index :referrers, :referrer_type_id
  end
end

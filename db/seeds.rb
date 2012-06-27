require 'csv'

# attendance reasons data from attendance_reasons csv file
puts "importing attendance reasons data..."
CSV.foreach("#{Rails.root}/db/data/attendance_reasons.csv") do |row|
  AttendanceReason.find_or_create_by_code_and_description_and_diary_reason(row[0],row[1],row[2])
end
puts "finished importing attendance reasons data."

# operational priorities data from operational_priority csv file
puts "importing operational priority data..."
CSV.foreach("#{Rails.root}/db/data/operational_priorities.csv") do |row|
  OperationalPriority.find_or_create_by_operational_priority row[0]
end
puts "finished importing operational priority data."

# patient status data from patient_statuses csv file
puts "importing patient status data..."
CSV.foreach("#{Rails.root}/db/data/patient_statuses.csv") do |row|
  PatientStatus.find_or_create_by_status row[0]
end
puts "finished importing patient status data."

# referral reason data from referral_reasons csv file
puts "importing referral reason data..."
CSV.foreach("#{Rails.root}/db/data/referral_reasons.csv") do |row|
  ReferralReason.find_or_create_by_reason row[0]
end
puts "finished importing referral reason data."

# referrer types data from referrer_types csv file
puts "importing referrer types data..."
CSV.foreach("#{Rails.root}/db/data/referrer_types.csv") do |row|
  ReferrerType.find_or_create_by_type row[0]
end
puts "finished importing referrer type data."

case Rails.env
  # call this with: rake db:seed :env=development
  when "development"
    
  # create test users
  puts "creating test users..."
  hr_person = Person.find_or_initialize_by_email_address("hresources@test.com")
  hr_person.update_attributes({
    :first_name => "John",
    :middle_name => "V",
    :last_name => "Carter",
    :title => "Mr",
    :date_of_birth => "1980-11-05"
  })
  hr_user = User.find_or_initialize_by_username("hresources")
  hr_user.update_attributes({
    :email => hr_person.email_address,
    :password => "abc123",
    :password_confirmation => "abc123",
    :track_referrals => "all"
  })
  hr_user.update_attribute(:person_id, hr_person.id)
  
  tl_person = Person.find_or_initialize_by_email_address("tleader@test.com")
  tl_person.update_attributes({
    :first_name => "Barbara",
    :middle_name => "F",
    :last_name => "Shehan",
    :title => "Mrs",
    :date_of_birth => "1968-19-02"
  })
  tl_user = User.find_or_initialize_by_username("tleader")
  tl_user.update_attributes({
    :email => tl_person.email_address,
    :password => "abc123",
    :password_confirmation => "abc123",
    :track_referrals => "initiated_and_assigned"
  })
  tl_user.update_attribute(:person_id, tl_person.id)
  
  tl_person_2 = Person.find_or_initialize_by_email_address("teaml@test.com")
  tl_person_2.update_attributes({
    :first_name => "Charlie",
    :middle_name => "B",
    :last_name => "Brigham",
    :title => "Mr",
    :date_of_birth => "1971-25-10"
  })
  tl_user_2 = User.find_or_initialize_by_username("teaml")
  tl_user_2.update_attributes({
    :email => tl_person_2.email_address,
    :password => "abc123",
    :password_confirmation => "abc123",
    :track_referrals => "initiated_and_assigned"
  })
  tl_user_2.update_attribute(:person_id, tl_person_2.id)
  puts "finished creating test users."
end

# attendance outcomes data from attendance_outcomes csv file
puts "importing attendance outcomes data..."
CSV.foreach("#{Rails.root}/db/data/attendance_outcomes.csv") do |row|
  AttendanceOutcome.find_or_create_by_title row[0]
end
puts "finished importing attendance outcomes data."


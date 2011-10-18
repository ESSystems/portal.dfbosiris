require 'csv'

# import referral reason data from referral_reasons csv file
puts "importing referral reason data..."
CSV.foreach("#{Rails.root}/db/data/referral_reasons.csv") do |row|
  ReferralReason.find_or_create_by_reason row[0]
end
puts "finished importing referral reason data."

# import patient status data from patient_statuses csv file
puts "importing patient status data..."
CSV.foreach("#{Rails.root}/db/data/patient_statuses.csv") do |row|
  PatientStatus.find_or_create_by_status row[0]
end
puts "finished importing patient status data."

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
  :password_confirmation => "abc123"
})
hr_user.update_attribute(:person_id, hr_person.id)

tm_person = Person.find_or_initialize_by_email_address("tmanager@test.com")
tm_person.update_attributes({
  :first_name => "Barbara",
  :middle_name => "F",
  :last_name => "Shehan",
  :title => "Mrs",
  :date_of_birth => "1968-19-02"
})
tm_user = User.find_or_initialize_by_username("tmanager")
tm_user.update_attributes({
  :email => tm_person.email_address,
  :password => "abc123",
  :password_confirmation => "abc123"
})
tm_user.update_attribute(:person_id, tm_person.id)
puts "finished creating test users."

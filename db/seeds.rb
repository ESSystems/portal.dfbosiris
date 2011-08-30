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
Factory.define :appointment do |a|
  a.association :person
  a.association :referral
  a.association :referral_reason
  a.user_id 10614
  a.diary_id 5
  a.from_date {Time.now + (60 * 60 * 48)}
  a.to_date {Time.now + (60 * 60 * 49)}
end

Factory.define :client do |f|
end

Factory.define :department do |f|
end

Factory.define :employee do |f|
  f.association :person
  f.association :client
  f.association :department
  f.association :job_class
  f.sap_number Forgery(:basic).number :at_least => 7, :at_most => 7
end

Factory.define :job_class do |f|
end

Factory.define :patient do |f|
  f.association :person
end

Factory.define :patient_status do |f|
  f.status Forgery(:lorem_ipsum).words(3)
end

Factory.define :person do |f|
  #f.association :employee
  f.first_name Forgery(:name).first_name
  f.last_name Forgery(:name).last_name
  f.middle_name Forgery(:lorem_ipsum).character
end

Factory.define :referral do |f|
  f.association :person
  f.association :patient_status
  f.case_nature Forgery(:lorem_ipsum).words(30)
  f.association :referral_reason
end

Factory.define :referral_reason do |f|
  f.reason Forgery(:lorem_ipsum).words(6)
end

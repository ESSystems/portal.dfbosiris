Factory.define :appointment do |a|
  a.association :person
  a.association :referral
  a.association :referral_reason
  a.association :diary
  a.user_id 10614
  a.from_date {Time.now + (60 * 60 * 48)}
  a.to_date {Time.now + (60 * 60 * 49)}
end

Factory.define :client do |f|
end

Factory.define :department do |f|
end

Factory.define :diary do |d|
  d.name Forgery(:name).full_name
  d.appointment_length 0
  d.available_days 0
  d.color_id 21
  d.start_time "00:00:00"
  d.end_time "00:00:00"
  d.owner_id 0
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

Factory.define :person do |p|
  #p.association :employee
  p.first_name Forgery(:name).first_name
  p.last_name Forgery(:name).last_name
  p.middle_name Forgery(:lorem_ipsum).character
end

Factory.define :referral do |f|
  f.association :person
  f.association :patient_status
  f.case_nature Forgery(:lorem_ipsum).words(30)
  f.association :referral_reason
  f.association :referrer, :factory => :user
end

Factory.define :referral_reason do |f|
  f.reason Forgery(:lorem_ipsum).words(6)
end

Factory.define :user do |u|
  u.association :person
  u.username { Forgery(:basic).text(:at_least => 6) }
  u.email { Forgery(:internet).email_address }
  u.password Forgery(:basic).password(:at_least => 6)
  u.track_referrals "all"
end

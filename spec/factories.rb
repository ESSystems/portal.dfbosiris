Factory.define :referral do |f|
  f.association :person
  f.association :patient_status
  f.case_nature "The pacient can't see the monitor"
  f.association :referral_reason
end

Factory.define :patient do |f|
  f.association :person
end

Factory.define :patient_status do |f|
  f.status "Off sick"
end

Factory.define :referral_reason do |f|
  f.reason "Short term sickness"
end

Factory.define :person do |f|
  f.first_name "John"
  f.last_name "Doe"
  f.middle_name "A."
end
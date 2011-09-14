Factory.define :referral do |f|
  f.association :person
  f.association :patient_status
  f.case_nature "The pacient can't see the monitor"
  f.association :referral_reason
  f.case_reference_number Forgery(:basic).number :at_least => 10, :at_most => 10
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
  #f.association :employee
  f.first_name "John"
  f.last_name "Doe"
  f.middle_name "A."
end

Factory.define :employee do |f|
  f.association :person
  f.association :client
  f.association :department
  f.association :job_class
  f.sap_number Forgery(:basic).number :at_least => 7, :at_most => 7
end

Factory.define :client do |f|
end

Factory.define :department do |f|
end

Factory.define :job_class do |f|
end

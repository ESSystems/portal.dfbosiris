Factory.define :referral do |f|
  f.case_nature "The pacient can't see the monitor"
  f.association :referral_reason
end

Factory.define :referral_reason do |f|
  f.reason "Short term sickness"
end
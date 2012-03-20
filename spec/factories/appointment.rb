Factory.define :appointment do |a|
  a.association :person
  a.association :referral
  a.association :referral_reason
  a.association :diary
  a.user_id 10614
  a.from_date {Time.now + (60 * 60 * 48)}
  a.to_date {Time.now + (60 * 60 * 49)}
end
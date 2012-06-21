FactoryGirl.define do
  factory :appointment do
    person
    referral
    referral_reason
    diary
    user_id 10614
    from_date {Time.now + (60 * 60 * 48)}
    to_date {Time.now + (60 * 60 * 49)}
  end
end

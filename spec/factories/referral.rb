FactoryGirl.define do 
  factory :referral do
    association :person
    association :patient_status
    job_information Forgery(:lorem_ipsum).words(30)
    case_nature Forgery(:lorem_ipsum).words(30)
    history Forgery(:lorem_ipsum).words(30)
    association :referral_reason
    association :operational_priority
    case_reference_number Forgery(:basic).encrypt
    association :referrer, :factory => :user
  end
end
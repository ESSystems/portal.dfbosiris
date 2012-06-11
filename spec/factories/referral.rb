FactoryGirl.define do 
  factory :referral do
    person
    patient_status
    job_information Forgery(:lorem_ipsum).words(30)
    case_nature Forgery(:lorem_ipsum).words(30)
    history Forgery(:lorem_ipsum).words(30)
    referral_reason
    operational_priority
    case_reference_number Forgery(:basic).encrypt
    association :referrer, :factory => :user
    private false
  end
end
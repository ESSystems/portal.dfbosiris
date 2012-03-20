FactoryGirl.define do 
  factory :person do
    #association :employee
    first_name Forgery(:name).first_name
    last_name Forgery(:name).last_name
    middle_name Forgery(:lorem_ipsum).character
  end
end
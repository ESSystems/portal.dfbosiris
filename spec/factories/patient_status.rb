FactoryGirl.define do
	factory :patient_status do
		status Forgery(:lorem_ipsum).words(3)
	end
end
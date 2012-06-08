FactoryGirl.define do
	factory :referral_reason do
		reason Forgery(:lorem_ipsum).words(6)
	end
end
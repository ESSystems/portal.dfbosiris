FactoryGirl.define do
	factory :user do
		person
		username { Forgery(:basic).text(:at_least => 6) }
		email { Forgery(:internet).email_address }
		password Forgery(:basic).password(:at_least => 6)
		track_referrals "all"
	end
end
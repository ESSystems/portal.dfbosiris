FactoryGirl.define do
	factory :attendance do
		appointment
		diagnosis_id Forgery(:basic).number
	end
end
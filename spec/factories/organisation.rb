FactoryGirl.define do
	factory :organisation do
		OrganisationID Forgery(:basic).number
	end
end
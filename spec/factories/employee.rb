FactoryGirl.define do
	factory :employee do
		person
  		client
  		department
  		job_class
  		sap_number Forgery(:basic).number :at_least => 7, :at_most => 7
  	end
end
FactoryGirl.define do
	factory :diary do
		name Forgery(:name).full_name
  		appointment_length 0
  		available_days 0
  		color_id 21
  		start_time "00:00:00"
  		end_time "00:00:00"
  		owner_id 0
  	end
end
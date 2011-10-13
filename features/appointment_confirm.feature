Feature: Confirm appointment or change appointment date
	As a user
	I want to confirm or cancel an appointment
	In order to fit my availability
	
	Background:
		Given the following patient status exists:
			| Off sick	|
		And the following referral reason exists:
			| Prolonged sickness referral 	|
		And the following person exists:
			| id	| first_name 	| middle_name	| last_name 	| date_of_birth |
			| 1		| Kishen		| B				| Luitger		| 1980-03-23	|
		And I have no referrals
		And the following referral exists:
			| id	| Person	| Patient status	| Case Nature	| Referral reason 						| Case Reference Number |
			| 85	| Id: 1		| Status: Off sick	| Fell off		| Reason: Prolonged sickness referral	| 4321534582			|
		
	Scenario: Confirm appointment
		Given the following appointment exists:
			| diary_id	| Person 	| from_date 			| to_date 				| Referral	| Referral reason 						|
			| 5			| Id: 1		| 2011-09-09 11:00:00	| 2011-09-09 12:00:00	| Id: 85	| Reason: Prolonged sickness referral	|
		And I am on the list of referrals 
		And I follow "View"
		When I follow "Confirm appointment"
		Then I should see "Appointment confirmed"
		And I should see "You confirmed the appointment for: 09 September, 2011 from 11:00 to 12:00"
		And I should not see "Confirm appointment"
		
	Scenario: Don't show confirm button if an appointment is not associated with the referral
		Given I am on the list of referrals
		And I follow "View"
		Then I should not see "Confirm appointment"
		

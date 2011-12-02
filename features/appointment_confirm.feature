Feature: Confirm appointment or change appointment date
	As a user
	I want to confirm or cancel an appointment
	In order to fit my availability

	Background:
		Given I am logged in with "initiated_and_assigned" rights
		And the following patient status exists:
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
		And the following diary exists:
			| id	| Name				|
			| 20	| Doctor Holland	|

	Scenario: Confirm appointment
		Given the following appointment exists:
			| Diary		| Person 	| from_date 			| to_date 				| Referral	| Referral reason 						|
			| Id: 20	| Id: 1		| 2011-09-09 11:00:00	| 2011-09-09 12:00:00	| Id: 85	| Reason: Prolonged sickness referral	|
		And I am on the list of referrals 
		And I follow "View"
		When I follow "Confirm appointment"
		Then I should see "Appointment confirmed"
		And I should see "You confirmed the appointment for: 09 September, 2011 from 11:00 to 12:00 with Doctor Holland"
		And I should not see "Confirm appointment"

	Scenario: Don't show confirm button if an appointment is not associated with the referral
		Given I am on the list of referrals
		And I follow "View"
		Then I should not see "Confirm appointment"
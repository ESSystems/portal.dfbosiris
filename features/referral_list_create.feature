Feature: Show the list of referrals and create a new one
	As an user with full rights
	I want to raise an electronic referral
	In order to schedule appointments for employees
	
	Background:
		Given following patient statuses exist:
			| Off sick				|
			| Phased return to work	|
			| At work				|
		Given following referral reasons exist:
			| Prolonged sickness referral 	|
			| Fitness to work 				|
			| Fitness to return to work 	|
			| Functional Assessment 		|
			| Short term sickness 			|
		Given following people exist:
			| id	| first_name 	| middle_name	| last_name 	| date_of_birth |
			| 1		| Kishen		| B				| Luitger		|				|
			| 2		| Valere		| 				| Romanus		| 1980-03-23	|
			| 3		| Bert			| S.			| Geraldo		|				|
			| 4		| Allyson		| 				| Ishee			|				|
		
	@javascript
	Scenario: Create Valid Referral
		Given I have no referrals 
		And I am on the list of referrals
		When I follow "New referral"
		And I fill in "Person" with "val"
		And I choose "Valere Romanus" in the autocomplete list
		And I select "Off sick" from selectmenu "Patient status"
		And I check "Patient consent"
		And I fill in the following:
			| Case nature	 			| Off sick for 3 months with a broken ankle. Fell off a ladder at home. 	|
			| Specific requirements 	| Be gentle.																|
			| Advice					| Stay in bed.																|
		And I select "Short term sickness" from selectmenu "Referral reason"
		And I fill in "Preferred date" with "31 August 2012"
		And I press "Create Referral"
		Then I should have 1 referral
		And I should see "New referral created."
		And I should see "Valere Romanus"
		And I should see "Off sick for 3 months with a broken ankle. Fell off a ladder at home."
		And I should see "Short term sickness"
	
	Scenario: Show referrals
		Given I have no referrals
		And the following referrals exist:
			| Person	| Patient status	| Case Nature	| Referral reason 				| Case Reference Number |
			| Id: 3		| Status: Off sick	| Fell off		| Reason: Long term disease 	| 4321534582			|
			| Id: 4 	| Status: At work	| Broken hand	| Reason: Short term sickness 	| 0853290543			|
		When I go to the list of referrals
		Then I should see "Bert S. Geraldo"
		And I should see "Fell off"
		And I should see "Long term disease"
		And I should see "0853290543"
		And I should see "Allyson Ishee"
		And I should see "Broken hand"
		And I should see "Short term sickness"
		And I should see "0853290543"
			
	@javascript
	Scenario: When choosing a person in the autocomplete list, there should be full name
		Given I am on the list of referrals 
		When I follow "New referral"
		And I fill in "Person" with "val"
		And I choose "Valere Romanus" in the autocomplete list
		Then the field with id "referral_person_id" should contain "2"
		And the "Person" field should contain "Valere Romanus"
		
	@javascript
	Scenario: When choosing a person in the autocomplete list, there should be SAP number
		Given the following employee exists:
			| person_id | sap_number 	|
			| 2			| 8001025		|
		And I am on the list of referrals 
		When I follow "New referral"
		And I fill in "Person" with "val"
		And I choose "8001025" in the autocomplete list
		Then the field with id "referral_person_id" should contain "2"
		And I should see "8001025"
		
	@javascript
	Scenario: When choosing a person in the autocomplete list, there should be date of birth
		Given I am on the list of referrals 
		When I follow "New referral"
		And I fill in "Person" with "val"
		And I choose "23 March, 1980" in the autocomplete list
		Then the field with id "referral_person_id" should contain "2"
		And I should see "23 March, 1980"
		
	@javascript
	Scenario: Show full list of people when pushing a button
		Given I am on the list of referrals
		When I follow "New referral"
		And I follow "Show all people"
		Then I should see all people in the autocomplete list
	
	Scenario: When choosing a date from the datepicker, date should be in the format: {dd} {month name} {year}
		Given I am on the list of referrals
		When I follow "New referral"
		
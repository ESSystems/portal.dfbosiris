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
			| id	| first_name 	| middle_name	| last_name 	|
			| 1		| Kishen		| B				| Luitger		|
			| 2		| Valere		| 				| Romanus		|
			| 3		| Bert			| S.			| Geraldo		|	
			| 4		| Allyson		| 				| Ishee			|
		
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
		And I have created the following referrals:
			| Person				| Patient Status	| Case Nature	| Referral Reason 		|
			| John B. Doe			| Off sick			| Fell off		| Long term disease 	|
			| Allyson M. Luitger 	| At work			| Broken hand	| Short term sickness 	|
		When I go to the list of referrals
		Then I should see "John B. Doe"
		And I should see "Fell off"
		And I should see "Long term disease"
		And I should see "Allyson M. Luitger"
		And I should see "Broken hand"
		And I should see "Short term sickness"
			
	Scenario: When choosing a person in the autocomplete list, there should be full name, SAP number and date of birth in the list
		Given I am on the list of referrals
		When I follow "New referral"
	
	Scenario: When choosing a date from the datepicker, date should be in the format: {dd} {month name} {year}
		Given I am on the list of referrals
		When I follow "New referral"
		
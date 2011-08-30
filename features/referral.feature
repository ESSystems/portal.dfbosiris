Feature: Referral
	As a client user
	I want to raise an electronic referral
	In order to schedule appointments for employees
	
	Background:
		Given following referral reasons exist:
			| Prolonged sickness referral 	|
			| Fitness to work 				|
			| Fitness to return to work 	|
			| Functional Assessment 		|
			| Short term sickness 			|
	
	Scenario: Create Valid Referral
		Given I have no referrals 
		And I am on the list of referrals
		When I follow "New referral"
		And I fill in the following:
			| Case nature 			| The pacient can't see the monitor |
			| Specific requirements | Only chineese 					|
			| Advice 				| Stay at home 						|
		And I select "Short term sickness" from "Referral reason"
		#And I am already set up as referrer
		And I press "Create Referral"
		Then I should see "New referral created."
		And I should have 1 referral
		
	Scenario: Create a complete Referral (i.e. with all form fields completed)
		Given I have created the following referrals:
			| case_nature 						|
			| The pacient can't see the monitor |
			| The pacient has a headache 		|
		When I go to the list of referrals
		Then I should see "The pacient can't see the monitor"
		And I should see "The pacient has a headache"
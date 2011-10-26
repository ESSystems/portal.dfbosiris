Given /^I have no referrals$/ do
  Referral.delete_all
end

Then /^I should have ([0-9]+) referral$/ do |count|
  Referral.count.should == count.to_i
end

Given /^following referral reasons exist:$/ do |table|
  table.hashes.each do |reason|
    Factory(:referral_reason, :reason => reason)
  end
end

Given /^following patient statuses exist:$/ do |table|
  table.hashes.each do |status|
    Factory(:patient_status, :status => status)
  end
end

Given /^following people exist:$/ do |table|
  table.hashes.each do |attributes|
    Factory(:person, attributes)
  end
end

Transform /^table:Person,Patient Status,Case Nature,Referral Reason$/ do |table|
  table.hashes.map do |hash|
    person = Factory(:person, :full_name => hash["Person"])
    patient_status = Factory(:patient_status, :status => hash["Patient Status"])
    referral = Factory(:referral, :case_nature => hash["Case Nature"])
    referral_reason = Factory(:referral_reason, :reason => hash["Referral Reason"])
    
    {:person => person, :patient_status => patient_status, :referral => referral, :referral_reason => referral_reason}
  end
end

Given /^I have created the following referrals:$/ do |table|
  table.each do |group|
    referral = group[:referral]
    associations = {:person => group[:person], :patient_status => group[:patient_status], :referral_reason => group[:referral_reason]}
    referral.update_attributes(associations)
  end
end

When /^I check "([^"]*)" and confirm "([^"]*)"$/ do |check, confirm|
  When %Q{I check "#{check}"}
  Then %Q{I should see "#{confirm}"}
  And %Q{I press "Ok"}
end

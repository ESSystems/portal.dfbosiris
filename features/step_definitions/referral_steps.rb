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

Given /^I have created the following referrals:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
  # table.hashes.each do |attributes|
  #     Factory.create(:referral, attributes)
  #   end
end




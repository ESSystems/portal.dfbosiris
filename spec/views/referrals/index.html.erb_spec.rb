require 'spec_helper'

describe "referrals/index.html.erb" do
  
  describe "show referral information" do
    let(:referral) do
      Factory(:referral)
    end
    
    before do
      assign(:referrals, [referral])
      
      visit referrals_path
    end
    
    it "should show case reference number" do
      page.should have_content(referral.case_reference_number)
    end
    
    it "should show patients full name" do
      page.should have_content(referral.person.full_name)
    end
    
    it "should show only 150 characters of case nature" do
      page.should have_content(referral.short_case_nature)
    end
    
    it "shouldn't show full case nature if it's longer that 150 characters" do
      page.should_not have_content(referral.case_nature)
    end
    
    it "should show referral reason" do
      page.should have_content(referral.referral_reason.reason)
    end
    
    it "should show a link to view information about a referral" do
      page.should have_link("View", :href => referral_path(referral))
    end
    
    it "should show a link to edit a referral" do
      page.should have_link("Edit", :href => edit_referral_path(referral))
    end
    
    it "should show a link to cancel a referral"
  end
  
end
require "spec_helper"

describe "referrals/new.html.erb" do
  
  let(:form_selector) do
    "//form[@id='new_referral' and @method='post' and @action='#{referrals_path}']"
  end
  
  let(:referral) do
    mock_model('Referral').as_new_record.as_null_object
  end
  
  before do
    assign(:referral, referral)
    
    visit new_referral_path
  end
  
  it "should render a form to create a new referral" do
    page.should have_selector(form_selector) 
    
    page.should have_selector(form_selector + "//input[@type='submit']")
  end
  
  it "should hide a field with patient id" do
    page.should have_selector(form_selector + "//input[@type='hidden' and @name='referral[patient_id]']")
  end
  
  it "should render a text field to enter a patient name" # do
  #     page.should have_selector(form_selector + "//input[@type='text' and @name='referral[patient]']")
  #   end
  
  it "text field to enter patient should suggest patient names"
  
  it "should have a button to show all patients"
  
  it "should render a select for patient status" do
    page.should have_selector(form_selector + "//select[@name='referral[patient_status_id]']")
  end
  
  it "should render a checkbox for patient consent" do
    page.should have_selector(form_selector + "//input[@type='checkbox' and @name='referral[patient_consent]']")
  end
  
  it "should render a text area for nature of case" do
    page.should have_selector(form_selector + "//textarea[@name='referral[case_nature]']")
  end
  
  it "should render a text area for specific requirements" do
    page.should have_selector(form_selector + "//textarea[@name='referral[specific_requirements]']")
  end
  
  it "should render a text area for advice" do
    page.should have_selector(form_selector + "//textarea[@name='referral[advice]']")
  end
  
  it "should render a select for referral reason" do
    page.should have_selector(form_selector + "//select[@name='referral[referral_reason_id]']")
  end
  
  it "should render a text field to enter preferred date" do
    page.should have_selector(form_selector + "//input[@type='text' and @name='referral[preferred_date]']")
  end
  
end
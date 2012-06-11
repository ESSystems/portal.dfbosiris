require "spec_helper"

describe "referrals/new.html.erb" do

  include Devise::TestHelpers
  
  let(:form_selector) do
    "//form[@id='new_referral' and @method='post' and @enctype='multipart/form-data' and @action='#{referrals_path}']"
  end
  
  let(:referral) do
    mock_model('Referral').as_new_record.as_null_object
  end
  
  before do
    login_user(:track_referrals => "initiated_and_assigned")
      
    visit new_referral_path

    assign(:referral, referral)
  end
  
  it "should render a multipart form to create new referral" do
    page.should have_selector(form_selector) 
    
    page.should have_selector(form_selector + "//button[@type='submit']")
  end
  
  it "should hide a field with person id" do
    page.should have_selector(form_selector + "//input[@type='hidden' and @name='referral[person_id]']")
  end
  
  it "should render a text field to enter a person's full name" do
    page.should have_selector(form_selector + "//input[@type='text' and @name='referral[person_full_name]']")
  end
  
  it "should render a select for patient status" do
    page.should have_selector(form_selector + "//select[@name='referral[patient_status_id]']")
  end

  it "patient_status label is 'Person status'" do
    page.should have_content("Person status")
  end

  it "patient_status label is not 'Patient status'" do
    page.should_not have_content("Patient status")
  end
  
  it "should render a text area for nature of case" do
    page.should have_selector(form_selector + "//textarea[@name='referral[case_nature]']")
  end

  it "should render a hint for case nature" do
    page.should have_content("Describe what is wrong with the patient")
  end
  
  it "should render a text area for job information" do
    page.should have_selector(form_selector + "//textarea[@name='referral[job_information]']")
  end

  it "should render a hint for job information" do
    page.should have_content("Please give details of current job/rotation")
  end
  
  it "should render a text area for history" do
    page.should have_selector(form_selector + "//textarea[@name='referral[history]']")
  end

  it "should render a hint for history" do
    page.should have_content("Please detail background to case")
  end

  it "should render a text field to enter a person's date sickness started" do
    page.should have_selector(form_selector + "//input[@type='text' and @name='referral[sickness_started]']")
  end

  it "should render a text field to enter a person's date sicknote expires" do
    page.should have_selector(form_selector + "//input[@type='text' and @name='referral[sicknote_expires]']")
  end

  it "should render a label for sicknote_expires" do
    page.find(form_selector + "//label[@for='referral_sicknote_expires']").should have_content("Date current fit note expires")
  end
  
  it "should render a select for referral reason" do
    page.should have_selector(form_selector + "//select[@name='referral[referral_reason_id]']")
  end
  
  it "should render a select for operational priority" do
    page.should have_selector(form_selector + "//select[@name='referral[operational_priority_id]']")
  end
  
  it "should render a button to upload attachments" do
    page.should have_selector(form_selector + "//button[@id='referral-file-to-upload']")
  end
  
  it "should render a checkbox to make a referral private" do
    page.should have_selector(form_selector + "//input[@type='checkbox' and @name='referral[private]']")
  end

  it "should render fields to assign other referrers" do
    page.should have_selector(form_selector + "//select[@name='referral[follower_ids][]']", :count => 1)
  end
  
end
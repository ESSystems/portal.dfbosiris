require 'spec_helper'

describe "referrals/show.html.erb" do
  
  describe "referral page" do
    let(:referral) do
      Factory(:referral)
    end
    
    describe "show referral information" do
      before do
        assign(:referral, referral)
      
        visit referral_path(referral)
      end
    
      it "should show case reference number" do
        page.should have_content(referral.case_reference_number)
      end
      
      it "should show patient's full name" do
        page.should have_content(referral.person.full_name)
      end
      
      it "should show patient's SAP number"
      
      it "should show patient's date of birth"
      
      it "should show patient's status"
      
      it "should show patient's consent"
      
      it "should show full case nature" do
        page.should have_content(referral.case_nature)
      end
      
      it "should show referral reason" do
        page.should have_content(referral.referral_reason.reason)
      end
      
      it "should show preferred date for a referral"
      
      it "should show specific requirements"
      
      it "should show advice"
      
      it "should show attached documents if there are any attached documents"

      it "should show a link to edit a referral" do
        page.should have_link("Edit", :href => edit_referral_path(referral))
      end
      
      it "should show a link to cancel a referral"
      
      it "should show referral followers if there are any followers"
    end
    
    describe "show appointment information" do
      let(:appointment) do
        Factory(:appointment, :referral => referral)
      end
      
      it "should show doctor name" do
        referral.appointment = appointment
        visit referral_path(referral)
        page.should have_content("with #{appointment.diary.name}")
      end
      
      it "should show that an appointment was created if one exists" do
        referral.appointment = appointment
        visit referral_path(referral)
        page.should have_content("An appointment was created for this referral: " << appointment.display_date)
      end
      
      it "should show that appointment was confirmed if it was" do
        appointment.confirmed = true
        referral.appointment = appointment
        visit referral_path(referral)
        page.should have_content("You confirmed the appointment for: " << appointment.display_date)
      end
    end
    
    describe "show appointment confirmation options" do
      let(:appointment) do
        Factory(:appointment, :referral => referral)
      end

      it "should show a link to confirm the appointment" do
        referral.appointment = appointment
        visit referral_path(referral)
        page.should have_link("Confirm appointment", :href => confirm_appointment_path(appointment))
      end
      
      it "should not show a link to confirm the appointment if it's already confirmed" do
        appointment.confirmed = true
        referral.appointment = appointment
        visit referral_path(referral)
        page.should_not have_link("Confirm appointment", :href => confirm_appointment_path(appointment))
      end
      
      it "should show a link to modify the appointment"
    end
  end
  
end
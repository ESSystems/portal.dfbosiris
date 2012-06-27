require 'spec_helper'

describe "referrals/show.html.erb" do

  include Devise::TestHelpers

  before do
    login_user
  end

  describe "referral page when the logged in user created the referral" do
    let(:referral) do
      create(:referral, :referrer => @logged_in_user)
    end

    describe "shows referral information" do
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

      it "shows patient's status" do
        page.should have_content(referral.patient_status.status)
      end

      it "patient_status label is 'Person status'" do
        page.should have_content("Person status")
      end

      it "patient_status label is not 'Patient status'" do
        page.should_not have_content("Patient status")
      end

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
        create(:appointment, :referral => referral)
      end

      before do
        referral.appointments << appointment
      end

      it "shows doctor name" do
        visit referral_path(referral)
        page.should have_content("with #{appointment.diary.name}")
      end

      it "shows that an appointment was created if one exists" do
        visit referral_path(referral)
        page.should have_content("An appointment was created for this referral. Please confirm the appointment if the date is convenient or choose another date")
      end

      it "should show that appointment was confirmed if it was" do
        appointment.confirm
        visit referral_path(referral)
        page.should have_content("Appointment confirmed for: " << appointment.display_date)
      end
    end

    describe "show appointment confirmation options" do
      let(:appointment) do
        create(:appointment, :referral => referral)
      end

      before do
        referral.appointments << appointment
      end

      it "should show a link to confirm the appointment" do
        visit referral_path(referral)
        page.should have_link("Confirm appointment", :href => confirm_appointment_path(appointment))
      end

      it "should not show a link to confirm the appointment if it's already confirmed" do
        appointment.confirm
        visit referral_path(referral)
        page.should_not have_link("Confirm appointment", :href => confirm_appointment_path(appointment))
      end

      it "should show a link to modify the appointment"
    end
  end

end
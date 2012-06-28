require 'spec_helper'

describe ReferralObserver do
	context "after_save" do
		context "when the referral is made private" do
			let(:referral) { create(:referral, :private => false) }
			let(:attendance) { create(:attendance, :no_work_contact => 'N') }
			let(:appointment) { create(:appointment, :referral => referral) }

			before do
				appointment.attendance = attendance
				appointment.save
				referral.private = true
				referral.save
				referral.reload
			end

			it "sets Attendance.no_work_contact to 'Y'" do
				attendance.reload
				attendance.no_work_contact.should eql('Y')
			end
		end

		context "when the referral is canceled" do
			let(:referral) { create(:referral, :state => "accepted") }
			let(:appointment) { create(:appointment, :referral => referral) }
			let(:user) { build(:user) }

			before do
				User.stub!(:current).and_return(user)
				appointment.save
				referral.cancel "reason to cancel"
				appointment.reload
			end

			it "sets a soft delete reason on appointment" do
				appointment.deleted_reason.should eq("The referral with case #{referral.case_reference_number} was canceled.")
			end
		end
	end
end

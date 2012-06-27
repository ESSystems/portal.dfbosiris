require 'spec_helper'

describe ReferralObserver do
	context "after_save" do
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
end

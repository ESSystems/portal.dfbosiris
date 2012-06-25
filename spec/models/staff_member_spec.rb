require 'spec_helper'

describe StaffMember do
	let(:staff_member) { create(:staff_member) }

	describe "is_staff_member?" do
		it "searches a staff member by id" do
			StaffMember.should_receive(:find_by_id).with(45354343672)
			StaffMember.is_staff_member?(45354343672)
		end

		context "the user is a staff member" do
			it "returns true" do
				StaffMember.is_staff_member?(staff_member.id).should be_true
			end
		end

		context "the user is not a staff member" do
			it "returns false" do
				StaffMember.is_staff_member?("fdhsakjh3243232").should be_false
			end

			it "does not return nil" do
				StaffMember.is_staff_member?("fdhsakjh3243232").should_not be_nil
			end
		end
	end
end
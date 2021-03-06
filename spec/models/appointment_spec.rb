require 'spec_helper'

describe Appointment do
  it { should have_db_column(:blocked).of_type(:boolean) }
end

describe Appointment do
  describe "display date" do
    let(:appointment) do
      create(:appointment)
    end

    it "should show appointment date" do
      appointment.display_date.should include("#{appointment.from_date.to_date}")
    end

    it "should show appointment interval" do
      appointment.display_date.should include("#{appointment.from_date.to_s(:hours_and_minutes)} to #{appointment.to_date.to_s(:hours_and_minutes)}")
    end

    it "should show appointment date and appoinment interval" do
      appointment.display_date.should eq("#{appointment.from_date.to_date} from #{appointment.from_date.to_s(:hours_and_minutes)} to #{appointment.to_date.to_s(:hours_and_minutes)}")
    end
  end

  it "confirm"

  describe "deleted?" do
    let(:appointment) { build(:appointment) }

    it "returns true when state is 'deleted'" do
      appointment.state = "deleted"
      appointment.deleted?.should be_true
    end

    it "returns false when state is not deleted" do
      appointment.state = "new"
      appointment.deleted?.should be_false
    end
  end

  # TODO check steps definitions to test corectly the feature
  describe "find overlapping dates" do
    let(:appointment) do
      create(:appointment, :diary_id => 20002, :from_date => Time.now - (60*60*24), :to_date => Time.now - (60*60*23))
    end

    let(:booked_appointment) do
      create(:appointment, :diary_id => 20002)
    end

    context "returns empty" do
      it "when start date is before booked start date and end date is after booked start date" do
        from_date = booked_appointment.from_date - (60 * 15)
        to_date = booked_appointment.from_date + (60 * 30)
        appointment.is_overlapping_another(from_date, to_date).should be_true
      end

      it "when start date is after booked start date and end date is after booked end date" do
        from_date = booked_appointment.from_date + (60 * 15)
        to_date = booked_appointment.to_date + (60 * 45)
        appointment.is_overlapping_another(from_date, to_date).should == true
      end

      it "when start date is after booked start date and end date is before booked end date" do
        from_date = booked_appointment.from_date + (60 * 15)
        to_date = booked_appointment.to_date - (60 * 15)
        appointment.is_overlapping_another(from_date, to_date).should == true
      end

      it "when start date is before booked start date and end date is after booked end date" do
        from_date = booked_appointment.from_date - (60 * 15)
        to_date = booked_appointment.to_date + (60 * 45)
        appointment.is_overlapping_another(from_date, to_date).should == true
      end
    end
  end

  describe "soft_delete" do
    let(:user) { build(:user) }

    before do
      User.stub!(:current).and_return(user)
    end

    context "when appointment date is in the future" do
      let(:appointment) { create(:appointment, :from_date => Time.now + (60*60*24), :to_date => Time.now + (60*60*23)) }

      before do
        appointment.soft_delete "reason to soft delete"
        appointment.reload
      end

      it "sets the state as 'deleted'" do
        appointment.state.should eq("deleted")
      end

      it "sets the person id of the user who deleted the referral" do
        appointment.deleted_by.should_not be_nil
      end

      it "sets the deleted_on date" do
        appointment.deleted_on.should_not be_nil
      end

      it "sets a deleted reason" do
        appointment.deleted_reason.should_not be_nil
      end
    end

    context "when appointment date is in the past it doesn't" do
      let(:appointment) { create(:appointment, :from_date => Time.now - (60*60*24), :to_date => Time.now - (60*60*23)) }

      before do
        appointment.soft_delete "reason to soft delete"
        appointment.reload
      end

      it "set the state as 'deleted'" do
        appointment.state.should_not eq("deleted")
      end

      it "set the person id of the user who deleted the referral" do
        appointment.deleted_by.should be_nil
      end

      it "set the deleted_on date" do
        appointment.deleted_on.should be_nil
      end

      it "set a deleted reason" do
        appointment.deleted_reason.should be_nil
      end
    end
  end
end

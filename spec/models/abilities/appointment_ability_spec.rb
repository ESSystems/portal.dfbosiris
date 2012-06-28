require 'spec_helper'

describe Ability do
  let(:referral) { create(:referral) }
  let(:appointment) { create(:appointment, :referral => referral) }
  let(:user) { create(:user, :track_referrals => "") }

  before do
    @ability = Ability.new(user)
  end

  context "when the user created the referral" do
    before :all do
      referral.referrer = user
    end

    context "when the appointment is not deleted" do
      before do
        appointment.state = "new"
      end

      it "confirms appointment" do
        @ability.should be_able_to(:confirm_appointment, appointment)
      end

      it "shows calendar data" do
        @ability.should be_able_to(:calendar_data, appointment)
      end

      it "updates calendar date" do
        @ability.should be_able_to(:calendar_update_date, appointment)
      end
    end

    context "when the appointment is deleted it doesn't" do
      before do
        appointment.state = "deleted"
      end

      it "confirm the appointment" do
        @ability.should_not be_able_to(:confirm_appointment, appointment)
      end

      it "show calendar data" do
        @ability.should_not be_able_to(:calendar_data, appointment)
      end

      it "update calendar date" do
        @ability.should_not be_able_to(:calendar_update_date, appointment)
      end
    end
  end

  context "when the user did not create the referral" do
    context "does not" do
      it "confirm appointment" do
        @ability.should_not be_able_to(:confirm_appointment, appointment)
      end

      it "show calendar data" do
        @ability.should_not be_able_to(:calendar_data, appointment)
      end

      it "update calendar date" do
        @ability.should_not be_able_to(:calendar_update_date, appointment)
      end
    end
  end
end

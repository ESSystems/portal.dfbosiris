require 'spec_helper'

describe Referral do

  describe "validation" do
    let(:referral) do
      build(:referral)
    end

    it "is not valid without a referrer" do
      referral.referrer = nil
      referral.should_not be_valid
    end

    it "is valid with valid attributes" do
      referral.should be_valid
    end

    it "is not valid without a person" do
      referral.person = nil
      referral.should_not be_valid
    end

    it "is not valid without patient status" do
      referral.patient_status = nil
      referral.should_not be_valid
    end

    it "is not valid without a case nature" do
      referral.case_nature = nil
      referral.should_not be_valid
    end

    it "is not valid without a referral reason" do
      referral.referral_reason = nil
      referral.should_not be_valid
    end

    it "is not valid without a case reference number" do
      referral.case_reference_number = nil
      referral.should_not be_valid
    end
  end

  it "should show '...' when case nature is longer than 150 characters" do
    long_case_nature = Forgery(:basic).text(:at_least => 170, :at_most => 180)
    referral = build(:referral, :case_nature => long_case_nature)
    referral.short_case_nature.should eq("#{long_case_nature.slice(0..150)}...")
  end

  it "should not show '...' when case nature is shorter than 150 characters" do
    short_case_nature = Forgery(:basic).text(:at_least => 100, :at_most => 140)
    referral = build(:referral, :case_nature => short_case_nature)
    referral.short_case_nature.should eq(short_case_nature)
  end

  it "has no followers when private is set to true" do
    referral = create(:referral, :private => false)
    referral.followers << create(:user)
    referral.private = true
    referral.save
    referral.followers.should be_empty
  end

  it "keeps private true if set true" do
    referral = create(:referral, :private => true)
    referral.private = false
    referral.should_not be_valid
  end

  it "can modify private if set to false" do
    referral = create(:referral, :private => false)
    referral.private = true
    referral.save
    referral.reload
    referral.private.should be_true
  end

  describe "scope public_and_owned" do
    context "when the user has 'all' track rights" do
      let(:user) { build(:user, :track_referrals => "all") }

      context "when the user is NOT the referrer" do
        let(:referral) {
          create(:referral, :private => true, :referrer => create(:user))
        }

        it "doesn't show private referrals" do
          referral
          Referral.public_and_owned(user.id).all.should_not include(referral)
        end
      end

      context "when the user is the referrer" do
        let(:referral) {
          create(:referral, :private => true, :referrer => user)
        }

        it "shows own private referrals" do
          referral
          Referral.public_and_owned(user.id).all.should include(referral)
        end
      end
    end
  end

  describe "cancel" do
    let(:referral) { create(:referral, :state => 'new') }

    before do
      referral.cancel "reason"
      referral.reload
    end

    it "sets the referral state to 'canceled'" do
      referral.state.should eq("canceled")
    end

    it "sets a canceled reason" do
      referral.canceled_reason.should eq("reason")
    end

    it "sets a canceled date" do
      referral.canceled_on.should_not be_nil
    end
  end

  describe "canceled?" do
    let(:referral) { build(:referral) }

    it "returns true when the referral's state is 'canceled'" do
      referral.state = "canceled"
      referral.canceled?.should be_true
    end

    it "returns false when the referral's state is not 'canceled'" do
      referral.state = "new"
      referral.canceled?.should be_false
    end
  end

  describe "generate_case_reference_number" do
    let(:case_number) { "32432REW38" }
    let(:existing_referral) { create(:referral, :case_reference_number => case_number) }

    it "is generated when the referral is created" do
      referral = build(:referral)
      referral.case_reference_number.should_not be_nil
    end

    it "searches for existing case number" do
      Referral.any_instance.stub(:random_number).and_return(case_number)
      Referral.should_receive(:find).with(:first, :conditions => {:case_reference_number => case_number})
      referral = build(:referral)
    end
  end

  describe "passes_late_cancelation_condition?" do
    let(:referral) { create(:referral) }

    it "returns true when conditions are met" do
      from_date = Time.now + 60 * 60 * (Referral::LATE_CANCELATION_INTERVAL + 24)
      to_date = Time.now + 60 * 60 * (Referral::LATE_CANCELATION_INTERVAL + 25)
      referral.appointments = [build(:appointment, :referral => referral, :from_date => from_date, :to_date => to_date)]
      referral.passes_late_cancelation_condition?.should be_true
    end

    it "returns false when conditions are not met" do
      from_date = Time.now + 60 * 60 * (Referral::LATE_CANCELATION_INTERVAL - 10)
      to_date = Time.now + 60 * 60 * (Referral::LATE_CANCELATION_INTERVAL - 9)
      referral.appointments = [build(:appointment, :referral => referral, :from_date => from_date, :to_date => to_date)]
      referral.passes_late_cancelation_condition?.should be_false
    end
  end
end

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

  it "should generate a case reference number when created" do
    referral = build(:referral)
    referral.case_reference_number.should_not be_nil
  end

  it "should show '...' only if case nature is longer than 150 characters"

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
end

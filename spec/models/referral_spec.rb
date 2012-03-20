require 'spec_helper'

describe Referral do
  let(:referral) do
    Factory.build(:referral)
  end

  describe "validation" do
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
    
    it "is not valid withous a case reference number" do
      referral.case_reference_number = nil
      referral.should_not be_valid
    end
  end
  
  it "should generate a case reference number when created"
    
  it "should show '...' only if case nature is longer than 150 characters"
end

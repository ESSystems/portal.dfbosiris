require 'spec_helper'

describe Referral do
  let(:factory_referral) do
    Factory.build(:referral)
  end
  
  before(:each) do
    @referral = Referral.new(
      :case_nature => factory_referral.case_nature,
      :referral_reason => mock_model(ReferralReason)
    )
  end
  
  it "is valid with valid attributes" do
    @referral.should be_valid
  end
  
  it "is not valid without a patient"
  
  it "is not valid without a case nature" do
    @referral.case_nature = nil
    @referral.should_not be_valid
  end
  
  it "is not valid without a referral reason" do
    @referral.referral_reason = nil
    @referral.should_not be_valid
  end
end

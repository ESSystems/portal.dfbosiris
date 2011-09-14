require 'spec_helper'

describe Referral do
  let(:factory_referral) do
    Factory.build(:referral)
  end
  
  before(:each) do
    @referral = Referral.new(
      :person => factory_referral.person,
      :patient_status => factory_referral.patient_status,
      :case_nature => factory_referral.case_nature,
      :referral_reason => factory_referral.referral_reason
    )
  end
  
  it "is valid with valid attributes" do
    @referral.should be_valid
  end
  
  it "is not valid without a person" do
    @referral.person = nil
    @referral.should_not be_valid
  end
  
  it "is not valid without patient status" do
    @referral.patient_status = nil
    @referral.should_not be_valid
  end
  
  it "is not valid without a case nature" do
    @referral.case_nature = nil
    @referral.should_not be_valid
  end
  
  it "is not valid without a referral reason" do
    @referral.referral_reason = nil
    @referral.should_not be_valid
  end
  
  it "should generate a case reference number when created"
end

require 'spec_helper'

describe Ability do

  let(:tleader) { Factory.create(:user, :track_referrals => "initiated_and_assigned") }
  let(:referral) { Factory.create(:referral, :referrer => tleader) }

  describe "user with initiated_and_assigned referrals tracking" do
    it "should read referrals he created" do
      ability = Ability.new(tleader)
      ability.should be_able_to(:read, referral)
    end
    
    it "should be able to edit a referrel he created" do
      ability = Ability.new(tleader)
      ability.should be_able_to(:update, referral)
    end

    it "should create referrals"

    it "should view referrals to which it's assigned"

    it "should view referrals he created on index"
  end
end

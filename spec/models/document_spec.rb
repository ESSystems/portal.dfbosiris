require 'spec_helper'

describe Document do

  it "is valid with valid attributes"

  it "is not valid without a file"

  describe "is_creator?" do
  	let(:document) { create(:document) }
  	let(:user) { create(:user) }
  	let(:referral) { create(:referral) }

  	before do
		referral.documents << document
  	end

  	context "the user created the referral to which the document is assigned" do
  		before do
  			referral.referrer = user
  			referral.save
  		end

  		it "returns true" do
  			document.is_creator?(user.id).should be_true
  		end
  	end

  	context "the user did not create the referral to which the document is assigned" do
  		it "returns false" do
  			document.is_creator?(user.id).should be_false
  		end

  		it "does not return nil" do
  			document.is_creator?(user.id).should_not be_nil
  		end
  	end
  end

  describe "is_follower?" do
  	let(:document) { create(:document) }
  	let(:user) { create(:user) }
  	let(:referral) { create(:referral) }

  	before do
		referral.documents << document
  	end

  	context "the user is a follower of the referral to which the document is assigned" do
  		before do
  			referral.followers << user
  			referral.save
  		end

  		it "returns true" do
  			document.is_follower?(user.id).should be_true
  		end
  	end

  	context "the user is not a follower of the referral to which the document is assigned" do
  		it "returns false" do
  			document.is_follower?(user.id).should be_false
  		end

  		it "does not return nil" do
  			document.is_follower?(user.id).should_not be_nil
  		end
  	end
  end

  describe "is_private?" do
  	let(:document) { create(:document) }
  	let(:referral) { create(:referral, :private => false) }

  	before do
		referral.documents << document
  	end

  	context "when the referral to which the document is assigned is private" do
  		before do
  			referral.private = true
  			referral.save
  		end

  		it "returns true" do
  			document.is_private?.should be_true
  		end
  	end

  	context "when the referral to which the document is assigned is not private" do
  		it "returns false" do
  			document.is_private?.should be_false
  		end

  		it "doesn not return nil" do
  			document.is_private?.should_not be_nil
  		end
  	end
  end
end


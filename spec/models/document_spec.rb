require 'spec_helper'

describe Document do

  it "is valid with valid attributes"

  it "is not valid without a file"

  describe "default_values" do
    context "assigns 'portal' as origin default value" do
      let(:document) { build(:document) }

      it "origin is nil before save" do
        document.origin.should be_nil
      end

      it "origin is 'portal' after save" do
        document.save
        document.origin.should eq("portal")
      end

      it "doesn't change existing value" do
        document.origin = 'some_origin'
        document.save
        document.origin.should_not eq("portal")
      end
    end
  end

  describe "from_osiris?" do
    let(:document) { build(:document) }

    it "returns true if origin equals osiris" do
      document.origin = "osiris"
      document.from_osiris?.should be_true
    end

    it "returns false if origin does not equal osiris" do
      document.origin = "portal"
      document.from_osiris?.should_not be_true
    end
  end

  describe "from_portal?" do
    let(:document) { build(:document) }

    it "returns true if origin equals portal" do
      document.origin = "portal"
      document.from_portal?.should be_true
    end

    it "returns false if origin does not equal portal" do
      document.origin = "osiris"
      document.from_portal?.should_not be_true
    end
  end

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

  describe "osiris_url" do
    it "has the format: 'http://OSIRIS_SERVER_NAME/download/:id/:fingerprint/:referrer/documents'" do
      User.stub(:current).and_return(build(:user))
      document = create(:document)
      document.osiris_url.should eq("http://#{OSIRIS_SERVER_NAME}/download/#{document.id}/#{document.document_fingerprint}/#{User.current.id}/documents")
    end
  end
end


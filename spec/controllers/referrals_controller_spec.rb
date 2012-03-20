require 'spec_helper'

describe ReferralsController do
  include Devise::TestHelpers

  describe "POST create" do
    
    let(:referral) {
      Factory.stub(:referral).as_null_object
    }

    let(:referral_attributes) {
      Factory.attributes_for(:referral, :referrer => Factory(:user))
    }
    
    let(:user) {
      Factory.create(:user)
    }

    before do
      sign_in user

      Referral.stub(:new).and_return(referral)
    end

    it "creates a new referral" do
      Referral.should_receive(:new).and_return(referral)
      post :create
    end

    it "should assign the current user as the referrer"

    it "sets the person's department as the department at referral time" do
      post :create
      pending "person department in referral"
    end
    
    context "when the referral saves successfully" do
      before do
        referral.stub(:save).and_return(true)
      end
      
      it "sets a flash[:notice] message" do
        post :create
        flash[:success].should eq("New referral created.")
      end
      
      it "redirects to the Referrals index" do
        post :create
        response.should redirect_to(:action => "index")
      end
    end
    
    context "when the referral fails to save" do
      before do
        referral.stub(:save).and_return(false)
      end
      
      it "assigns @referral" do
        post :create
        assigns[:referral].should eq(referral_attributes)
      end
      
      it "renders the new template" do
        post :create
        response.should render_template("new")
        flash[:error].should eq("Could not create new referral.")
      end
    end
  end
  
  describe "PUT update" do
    let(:referral) {Factory(:referral)}
    
    it "should not modify the user that created the referral, i.e. referrer_id"

    context "when the referral saves successfully" do
      it "redirects to referral view page"
    end
    
    context "when the referral fails to save" do
      it "renders the edit template"
    end
  end
  
end
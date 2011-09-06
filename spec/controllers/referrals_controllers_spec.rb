require 'spec_helper'

describe ReferralsController do
  
  describe "responding to GET new" do
    it "should expose a new referral as @referral" do
      # referral = Factory.build(:referral)
      #       Referral.should_receive(:new).and_return(referral)
      #       assigns[:referral].should equal(referral)
    end
  end
  
  describe "POST create" do
    let(:referral) { mock_model(Referral).as_null_object }
    
    before do
      Referral.stub(:new).and_return(referral)
    end
    
    it "creates a new referral" do
      Referral.should_receive(:new).and_return(referral)
      post :create
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
        assigns[:referral].should eq(referral)
      end
      
      it "renders the new template" do
        post :create
        response.should render_template("new")
        flash[:error].should eq("Could not create new referral.")
      end
    end
  end
  
end
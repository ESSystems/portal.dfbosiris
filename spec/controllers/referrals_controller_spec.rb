require 'spec_helper'

describe ReferralsController do
  login_user

  describe "POST create" do
    
    let!(:person) { create :person }

    let(:referral) {
      mock_model(Referral, :person => person).as_null_object
    }

    let!(:referral_attributes) {
      build(:referral).attributes
    }
    
    let!(:user) {
      create(:user)
    }

    before do
      Department.stub(:get_name).and_return( "Dept" )
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
        assigns[:referral].should eq(referral)
      end
      
      it "renders the new template" do
        post :create
        response.should render_template("new")
        flash[:error].should eq("Could not create new referral.")
      end
    end
  end
  
  describe "PUT update" do
    let(:referral) {
      mock_model(Referral, :appointment => nil)
    }
    
    it "should not modify the user that created the referral, i.e. referrer_id"

    context "when the referral saves successfully" do
      it "redirects to referral view page"
    end
    
    context "when the referral fails to save" do
      before do
        Referral.stub(:find).and_return(referral)
        referral.stub(:declined?).and_return(false)
      end

      it "renders edit when referral doesn't update" do
        referral.stub(:update_attributes).and_return false
        put :update
        response.should render_template("edit")
      end
    end
  end

  describe "index" do
    context "when the user can track all referrals" do
      before do
        subject.current_user.track_referrals = 'all'
      end

      it "views public referrals" do
        referral = create(:referral, :private => false, :referrer => create(:user))
        get :index
        assigns[:referrals].should include(referral)
      end 

      it "doesn't view private referrals" do
        referral = create(:referral, :private => true)
        get :index
        assigns[:referrals].should_not include(referral)
      end

      it "views own referrals" do
        referral = create(:referral, :private => false, :referrer => subject.current_user)
        get :index
        assigns[:referrals].should include(referral)
      end
    end
  end
  
end
require 'spec_helper'

describe ReferralsController do
  login_user

  describe "DELETE destroy" do
    let(:referral) {
      mock_model(Referral, :id => "2", :appointments => [], :referrer => subject.current_user, :state => "new")
    }

    before do
      Referral.stub!(:find).with(referral.id).and_return(referral)
      Referral.stub!(:find_by_id).with(referral.id).and_return(referral)
    end

    it "calls find_by_id on Referral" do
      Referral.should_receive(:find_by_id).with(referral.id)
      delete :destroy, :id => referral.id
    end

    it "redirects to index" do
      delete :destroy, :id => referral.id
      response.should redirect_to(:action => "index")
    end

    it "calls destroy on referral" do
      referral.should_receive(:destroy)
      delete :destroy, :id => referral.id
    end

    it "shows a success message when the referral is destroyed" do
      referral.stub(:destroy).and_return(true)
      delete :destroy, :id => referral.id
      flash[:success].should eq("The referral was successfully deleted")
    end

    it "shows an error message when the referral is not destroyed" do
      referral.stub(:destroy).and_return(false)
      delete :destroy, :id => referral.id
      flash[:error].should eq("The referral could not be deleted")
    end

    it "shows an error message when the referral is not found" do
      Referral.stub!(:find_by_id).with(referral.id).and_return(nil)
      delete :destroy, :id => referral.id
      flash[:error].should eq("The referral you requested could not be found")
    end

    context "when a referral is found" do
      before do
        Referral.stub!(:find_by_id).with(referral.id).and_return(referral)
      end

      it "verifies if any appointment is set" do
        referral.appointments.should_receive(:empty?)
        delete :destroy, :id => referral.id
      end
    end
  end

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

  describe "cancel" do
    let(:referral) {
      mock_model(Referral, :referrer => subject.current_user, :appointments => [build(:appointment)])
    }

    before do
      Referral.stub!(:find).and_return(referral)
      referral.stub(:canceled?).and_return(false)
      referral.stub(:passes_late_cancelation_condition?).and_return(true)
    end

    it "redirects to index" do
      put :cancel, :id => 12
      response.should redirect_to(:action => "index")
    end

    it "calls find_by_id on Referral" do
      Referral.should_receive(:find_by_id).with("12").and_return(referral)
      referral.stub(:cancel).and_return(true)
      put :cancel, :id => 12
    end

    it "shows an error message when the referral is not found" do
      Referral.should_receive(:find_by_id).with("12").and_return(nil)
      put :cancel, :id => 12
      flash[:error].should eq("The referral you requested could not be found or a reason for cancelation was not given")
    end

    context "when the referral is found" do
      before do
        Referral.should_receive(:find_by_id).with("12").and_return(referral)
      end

      it "verifies that the referral passes late cancelation" do
        referral.should_receive(:passes_late_cancelation_condition?)
        referral.stub(:cancel).and_return(true)
        put :cancel, :id => 12, :reason => "reason"
      end

      context "when an appointment passes late cancelation condition" do
        before do
          referral.stub(:passes_late_cancelation_condition?).and_return(true)
        end

        it "calls cancel on referral" do
          referral.should_receive(:cancel).with("reason")
          put :cancel, :id => 12, :reason => "reason"
        end

        it "show a success message if cancel was succesful" do
          referral.stub(:cancel).and_return(true)
          put :cancel, :id => 12, :reason => "reason"
          flash[:success].should eq("The referral was canceled successfully")
        end

        it "shows an error message if cancel was not succesful" do
          referral.stub(:cancel).and_return(false)
          put :cancel, :id => 12, :reason => "reason"
          flash[:error].should eq("The referral could not be canceled")
        end
      end

      context "when an appointment doesn't pass late cancelation condition" do
        before do
          referral.stub(:passes_late_cancelation_condition?).and_return(false)
        end

        it "doesn't call cancel on referral" do
          referral.should_not_receive(:cancel).with("reason")
          put :cancel, :id => 12, :reason => "reason"
        end

        it "shows an error message" do
          put :cancel, :id => 12, :reason => "reason"
          flash[:error].should eq("An appointment has been scheduled in the next 48 hours.  Please contact a member of staff from IOH directly.")
        end
      end
    end
  end

  describe "PUT update" do
    let(:referral) {
      create(:referral, :referrer => subject.current_user)
    }

    it "should not modify the user that created the referral, i.e. referrer_id"

    context "when the referral saves successfully" do
      it "redirects to referral view page" do
        Referral.stub(:find).and_return(referral)
        referral.stub(:update_attributes).and_return true
        put :update, :id => 10
        response.should redirect_to(:controller => 'referrals', :action => 'show', :id => 10)
      end
    end

    context "when the referral fails to save" do
      before do
        Referral.stub(:find).and_return(referral)
        referral.stub(:declined?).and_return(false)
      end

      it "renders edit when referral doesn't update" do
        referral.stub(:update_attributes).and_return false
        put :update, :id => 10
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

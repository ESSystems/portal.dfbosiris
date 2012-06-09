require 'spec_helper'

describe AppointmentsController do

  login_user

  let(:appointment) do
    mock_model(Appointment, :id => 1, :referral_id => 2)
  end
  
  describe "confirm appointment" do
    before do
      Appointment.stub!(:find).with("1").and_return(appointment)
    end
    
    context "when the appointment saves successfully" do
      before do
        appointment.stub(:update_attribute).and_return(true)
        appointment.stub(:confirm).and_return(true)
      end
      
      it "calls appointment confirm" do
        appointment.should_receive(:confirm)
        get :confirm_appointment, :id => appointment.id
      end
      
      it "should redirect to associated referral page" do
        get :confirm_appointment, :id => appointment.id
        response.should redirect_to(:controller => 'referrals', :action => 'show', :id => appointment.referral_id)
      end
    
      it "sets a flash[:success] message" do
        get :confirm_appointment, :id => appointment.id
        flash[:success].should eq("Appointment confirmed")
      end
    end
    
    context "when the appointment fails to save" do
      before do
        appointment.stub(:update_attribute).and_return(false)
        appointment.stub(:confirm).and_return(false)
      end
      
      it "should redirect to associated referral page" do
        get :confirm_appointment, :id => appointment.id
        response.should redirect_to(:controller => 'referrals', :action => 'show', :id => appointment.referral_id)
      end
      
      it "sets a flash[:error] message" do
        get :confirm_appointment, :id => appointment.id
        flash[:error].should eq("Appointment could not be confirmed")
      end
    end
  end
  
end

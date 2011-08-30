class ReferralsController < ApplicationController
  
  def index
    @referrals = Referral.all
  end
  
  def new
    @referral = Referral.new
    @patient_statuses = PatientStatus.all
    @referral_reasons = ReferralReason.all
  end
  
  def create
    @referral = Referral.new(params[:referral])
    if @referral.save
      flash[:notice] = "New referral created."
      redirect_to :action => "index"
    else
      render :action => "new"
    end
    
  end
  
end
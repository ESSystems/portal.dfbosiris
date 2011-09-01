class ReferralsController < ApplicationController
  
  autocomplete :patient, :full_name, :full => true

  before_filter :init
  
  def init
    @patient_statuses = PatientStatus.all
    @referral_reasons = ReferralReason.all
  end

  def index
    @referrals = Referral.all
  end
  
  def new
    @referral = Referral.new
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
  
  def autocomplete_patient_full_name
    @patients = Patient.find_by_full_name params[:term]
    respond_to do |format|
      format.json { render :json => @patients }
    end
  end
  
end
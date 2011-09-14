class ReferralsController < ApplicationController
  
  autocomplete :person, :full_name, :full => true

  before_filter :init
  
  def init
    @patient_statuses = PatientStatus.all
    @referral_reasons = ReferralReason.all
  end

  def index
    @referrals = Referral.all
  end
  
  def show
    @referral = Referral.find(params[:id])
  end
  
  def edit
    @referral = Referral.find(params[:id])
  end
  
  def new
    @referral = Referral.new
  end
  
  def create
    @referral = Referral.new(params[:referral])
    if @referral.save
      flash[:success] = "New referral created."
      redirect_to :action => "index"
    else
      flash.now[:error] = "Could not create new referral."
      render :action => "new"
    end
  end
  
  def update
    @referral = Referral.find(params[:id])
    if @referral.update_attributes(params[:referral])
      flash[:success] = "Referral was successfully updated."
      redirect_to :action => "show"
    else
      flash.now[:error] = "Could not update the referral."
      render :action => "edit"
    end
  end
  
  def autocomplete_person_full_name
    @persons = Person.find_by_full_name(params[:term])
    @persons.collect! do |p|
      result = {}
      result["id"] = p.id
      result["value"] = p.full_name
      result["label"] = p.full_name
      result["sap_number"] = p.employee.sap_number unless p.employee == nil
      result["dob"] = "#{p.date_of_birth}"
      result
    end
    respond_to do |format|
      format.json { render :json => @persons }
    end
  end
  
end
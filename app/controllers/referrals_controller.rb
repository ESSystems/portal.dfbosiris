class ReferralsController < ApplicationController
  
  autocomplete :person, :full_name, :full => true

  before_filter :init_options, :only => [:new, :edit, :update, :create]
  
  load_and_authorize_resource
  
  def init_options
    @patient_statuses = PatientStatus.all
    @referral_reasons = ReferralReason.all
  end

  def index
    if !current_user.nil?
      if current_user.track_referrals == "all"
        @referrals = Referral.all
      elsif current_user.track_referrals == "initiated_and_assigned"
        @referrals = Referral.initiated_and_assigned(current_user.id)
      end
    end
  end
  
  def show
    @referral = Referral.find(params[:id])
  end
  
  def edit
    @referral = Referral.find(params[:id])
    @allow_edit = @referral.appointment.nil? ? true : false
  end
  
  def new
    @referral = Referral.new
    @allow_edit = true
  end
  
  def cancel
  end
  
  def create
    @referral = Referral.new(params[:referral])
    @referral.referrer = current_user
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
    
    # remove fields that should not be updated if an appointment was created
    if(!@referral.appointment.nil?)
      params[:referral].delete_if { |key, value|
        ["patient_status", "case_nature", "specific_requirements", "advice", "referral_reason", "preferred_date"].index(key) != nil
      }
    end
    
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
      result["organisation"] = p.employee.organisation.organisation_name unless p.employee == nil || p.employee.organisation == nil
      result["sap_number"] = p.employee.sap_number unless p.employee == nil
      result["dob"] = "#{p.date_of_birth}"
      result
    end
    respond_to do |format|
      format.json { render :json => @persons }
    end
  end
  
  def followers_suggestions
    @followers = User.find_by_full_name(params[:q])
    @followers.collect! do |f|
      result = {}
      result["id"] = f.id
      result["name"] = f.person.full_name
      result
    end
    respond_to do |format|
      format.json { render :json => @followers }
    end
  end
end
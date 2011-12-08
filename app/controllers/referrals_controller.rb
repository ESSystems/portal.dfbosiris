class ReferralsController < ApplicationController
  
  autocomplete :person, :full_name, :full => true

  before_filter :init_options, :only => [:new, :edit, :update, :create]
  
  load_and_authorize_resource
  
  helper_method :sort_column, :sort_direction
  
  def init_options
    @patient_statuses = PatientStatus.all
    @referral_reasons = ReferralReason.all
    @operational_priorities = OperationalPriority.all
  end

  def index
    if !current_user.nil?
      ordered_referral = Referral.order(sort_column + ' ' + sort_direction)
      if current_user.track_referrals == "all"
        @referrals = ordered_referral.page(params[:page])
      elsif current_user.track_referrals == "initiated_and_assigned"
        @referrals = ordered_referral.initiated_and_assigned(current_user.id).page(params[:page])
      end
    end
  end
  
  def show
    @referral = Referral.find(params[:id])
    @show_appointment = false
    @show_confirmed = false
    @show_attendance = false
    @show_all_appointments = false
    
    if @referral.appointments.count > 1
      @show_all_appointments = true
    elsif @referral.appointment
      @show_appointment = true
      
      @show_confirmed = @referral.appointment.confirmed?
      @show_confirm = @referral.appointment.new?
      if @referral.appointment.attendance
        @show_attendance = true
        @show_feedback = true if @referral.appointment.attendance.attendance_feedback 
      end
    end
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
    @allow_edit = true
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
        ["patient_status", "case_nature", "specific_requirements", "advice", "referral_reason"].index(key) != nil
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
    @persons = Person.find_by_full_name(params[:term]).people_in_organisation(current_user.client_id)
    @persons.collect! do |p|
      result = {}
      result["id"] = p.id
      result["value"] = p.full_name
      result["label"] = p.full_name
      if p.employee != nil && p.employee.organisation != nil
        result["organisation"] = p.employee.organisation.organisation_name
      elsif p.outside_person != nil && p.outside_person.organisation != nil
        result["organisation"] = p.outside_person.organisation.organisation_name
      end
      result["sap_number"] = p.employee.sap_number unless p.employee == nil
      result["dob"] = "#{p.date_of_birth}"
      result
    end
    respond_to do |format|
      format.json { render :json => @persons }
    end
  end
  
  def followers_suggestions
    @followers = User.find_by_full_name(params[:q]).users_in_organisation(current_user.client_id)
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
  
  private
  
  def sort_column
    Referral.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end
end
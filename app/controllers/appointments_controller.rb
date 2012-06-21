class AppointmentsController < ApplicationController

  load_and_authorize_resource

  def confirm_appointment
    @appointment = Appointment.find(params[:id])
    if @appointment.confirm
      flash[:success] = "Appointment confirmed"
    else
      flash[:error] = "Appointment could not be confirmed"
    end
    redirect_to :controller => "referrals", :action => "show", :id => @appointment.referral_id
  end

  def calendar_data
    @new_appointment = Appointment.find(params[:id])
    @appointments = Appointment.where(:diary_id => @new_appointment.diary.id)
    @appointments.collect! do |f|
      if f.id != @new_appointment.id
        calendar_event(f.id, "Booked", "This interval is already booked", f.from_date, f.to_date, "unavailable", false)
      else
        title = "Appointment for " << f.person.full_name
        description = "Appointment for " << f.person.full_name << " with " << f.diary.name
        calendar_event(f.id, title, description, f.from_date, f.to_date, "editable", true)
      end
    end
    respond_to do |format|
      format.json { render :json => @appointments }
    end
  end

  def calendar_update_date
    response = {}
    @appointment = Appointment.find(params[:id])
    if !@appointment.is_overlapping_another(params[:from_date], params[:to_date])
      @appointment.update_attributes({:from_date => params[:from_date], :to_date => params[:to_date]})
      response["type"] = ""
      response["response"] = ""
    else
      response["type"] = "overlapping_date"
      response["response"] = "Patient's appointment can't overlap an already booked one."
    end
    respond_to do |format|
      format.json { render :json => response }
    end
  end

  private

  def calendar_event(id, title, description, startDate, endDate, className, editable)
    result = {}
    result["id"] = id
    result["title"] = title
    result["description"] = description
    result["start"] = startDate
    result["end"] = endDate
    result["className"] = className
    result["editable"] = editable
    result
  end
end
class AppointmentsController < ApplicationController
  
  def confirm_appointment
    @appointment = Appointment.find(params[:id])
    if @appointment.update_attribute(:confirmed, true)
      flash[:success] = "Appointment confirmed"
    else
      flash[:error] = "Appointment could not be confirmed"
    end
    redirect_to :controller => "referrals", :action => "show", :id => @appointment.referral_id
  end
end
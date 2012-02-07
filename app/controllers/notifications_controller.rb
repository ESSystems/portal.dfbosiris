class NotificationsController < ApplicationController

  load_and_authorize_resource
  
  def index
    @notifications = Notification.associated_notifications("Referrer", current_user.id).page(params[:page])
  end

  def read
    @notification = Notification.find(params[:id])
    success = @notification.update_attribute("read", true)
    
    respond_to do |format|
      format.json {render :json => success}
    end
  end
end
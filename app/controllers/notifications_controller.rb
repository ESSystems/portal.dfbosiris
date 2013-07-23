class NotificationsController < ApplicationController

  load_and_authorize_resource

  def index
    @notifications = Kaminari.paginate_array(Notification.associated_notifications("Referrer", current_user.id)).page(params[:page]).per(15)
  end

  def read
    @notification = Notification.find(params[:id])
    success = @notification.update_attributes :read => true, :read_date => Time.now.to_s(:db)

    respond_to do |format|
      format.json {render :json => success}
    end
  end
end

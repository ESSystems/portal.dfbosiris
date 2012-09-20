class UsersController < ApplicationController

  load_and_authorize_resource

  def dashboard
    if !current_user.nil?
      ordered_referral = Referral.order("created_at DESC").limit(5)
      if current_user.track_referrals == "all"
        @referrals = ordered_referral.public_and_owned(current_user.id)
      elsif current_user.track_referrals == "initiated_and_assigned"
        @referrals = ordered_referral.initiated_and_assigned(current_user.id)
      end

      @notifications = Notification.associated_notifications("Referrer", current_user.id, 5)
    end
  end

  def edit
    @user = User.find(current_user)
  end

  def update
    @user = User.find(current_user.id)
    success = false

    if @user.update_with_password(params[:user])
      flash[:success] = "Your account was successfully updated."
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      flash.now[:error] = "Could not update your account."
      render :action => "edit"
    end
  end
end
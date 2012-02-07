class UsersController < ApplicationController

  def edit
    @user = User.find(current_user)
  end
  
  def update
    @user = User.find(current_user.id)
    success = false
    
    # if params[:user][:password] == ''
      # if @user.update_without_password(params[:user])
        # success = true
      # end
    # else
      # if @user.update_with_password(params[:user])
        # success = true
      # end
    # end
    
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
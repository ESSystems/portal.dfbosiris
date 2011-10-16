class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout
  
  def layout
    # show different layout for devise login
    is_a?(Devise::SessionsController) ? "login" : "application"
  end
  
  rescue_from CanCan::AccessDenied do |exception|  
    flash[:error] = "Access denied! Please login first!"  
    redirect_to user_session_url  
  end
  
  def after_sign_out_path_for(resource_or_scope)
    user_session_url
  end
end

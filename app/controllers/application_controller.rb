class ApplicationController < ActionController::Base
  before_filter :set_current_user
  protect_from_forgery

  layout :layout

  def after_sign_out_path_for(resource_or_scope)
    user_session_url
  end

  def layout
    # show different layout for devise login
    is_a?(Devise::SessionsController) ? "login" : "application"
  end

  def set_current_user
    User.current = current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    if !current_user.nil?
      flash[:error] = "You don't have access to this resource or to the action you are trying to make! Please contact your supervisor or IOH Staff Members!"
      redirect_to root_url
    elsif
      flash[:error] = "Access denied! Please login first!"
      redirect_to user_session_url
    end
  end

  rescue_from ActionController::MissingFile do |e|
    flash[:error] = "There was a problem accessing the file you requested"
    redirect_to root_url
  end

  rescue_from Timeout::Error, Errno::ENOENT do |e|
    logger.debug e
    flash[:error] = "There was a problem accessing the page you requested"
    redirect_to root_url
  end
end

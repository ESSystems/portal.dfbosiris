class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout
  
  def layout
    # show different layout for devise login
    is_a?(Devise::SessionsController) ? "login" : "application"
  end
end

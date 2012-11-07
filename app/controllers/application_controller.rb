require 'lib/bad_username_or_password_error.rb'
  
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  around_filter :set_user
  
  def login
    user = User.find_user params[:name], params[:password]
    
    session[:user] = user
    
    redirect_to root_path
  rescue BadUsernameOrPasswordError => e
    render "application/login", :notice => e.message
  end
  
  def logout
    session[:user] = nil
    
    redirect_to login_path
  end
  
  private
  def set_user
    @current_user = session[:user]
    
    yield
    
    @current_user = nil
  end
end

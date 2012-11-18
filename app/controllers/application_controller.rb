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
  
  def render_general_error
    render '/application/error_page', :locals => {:status => "500 Internal Server Error", :notice => env["action_dispatch.exception"].message}
  end
  
  def render_404_not_found
    render '/application/error_page', :locals => {:status => "404 Not Found", :notice => env["action_dispatch.exception"].message}
  end

  private
  def set_user
    @current_user = session[:user]

    yield

    @current_user = nil
  end
end

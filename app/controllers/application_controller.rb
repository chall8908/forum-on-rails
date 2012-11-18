class ApplicationController < ActionController::Base
  protect_from_forgery
  
  unless config.consider_all_requests_local
    rescue_from Exception, :with => :render_general_error #500 page
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404_not_found
    rescue_from ActionController::RoutingError, :with => :render_404_not_found
    rescue_from ActionController::UnknownController, :with => :render_404_not_found
    rescue_from AbstractController::ActionNotFound, :with => :render_404_not_found
  end

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
  
  private
  def render_general_error(e)
    logger.error e
    render '/application/error_page', :locals => {:status => "500 Internal Server Error", :notice => e.message}
  end
  
  def render_404_not_found(e)
    render '/application/error_page', :locals => {:status => "404 Not Found", :notice => e.message}
  end
end

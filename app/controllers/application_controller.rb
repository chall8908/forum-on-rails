class ApplicationController < ActionController::Base

  protect_from_forgery

  def forem_user
    User.find(session[:user_id])
  rescue
    nil
  end
  helper_method :forem_user

  def login
    user = User.find_user params[:name], params[:password]

    session[:user_id] = user.id

    redirect_to root_path
  rescue BadUsernameOrPasswordError => e
    @error = e.message
    render "application/login"
  end

  def logout
    session[:user_id] = nil

    redirect_to login_path
  end

  def render_general_error
    @error = $!.andand.message
    render_error_page "500 Internal Server Error", "Our server has encountered an error and couldn't finish your request.  We're sorry!"
  end

  def render_404_not_found
    @error = $!.andand.message
    render_error_page "404 Not Found", "The page you're looking for isn't here.  Please try again elsewhere.  Maybe you'll find it."
  end

  private

  def render_error_page(status, message)
    render '/application/error_page', :locals => {:status => status, :message => message}
  end
end

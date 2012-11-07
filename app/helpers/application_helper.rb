module ApplicationHelper
  def current_user
    session[:user]
  end

  def logged_in?
    not current_user.blank?
  end
  
  def user_is_admin?
    current_user.andand.has_permission? :admin
  end
end

module ApplicationHelper
  def logged_in?
    not @current_user.nil?
  end
  
  def user_is_admin?
    @current_user.andand.has_permission? :admin
  end
end

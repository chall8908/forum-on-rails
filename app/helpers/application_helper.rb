module ApplicationHelper
  def logged_in?
    not forem_user.blank?
  end
  
  def user_is_admin?
    forem_user.andand.forem_admin
  end
end

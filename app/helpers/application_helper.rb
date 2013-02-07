module ApplicationHelper
  def logged_in?
    not forem_user.blank?
  end
  
  def user_is_admin?
    forem_user.andand.forem_admin
  end

  def tab_link(value, path)
    link_to value, path, class: "user-dashboard-tab #{request.path === path ? "active" : ""}"
  end
end

class Admin::ApplicationController < ApplicationController
  before_filter :check_permissions

  private
  def check_permissions
    redirect_to root_path unless forem_user.forem_admin
  end
end

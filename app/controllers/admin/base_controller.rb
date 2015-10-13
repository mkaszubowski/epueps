class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :check_if_can_view_page

  protected

  def check_if_can_view_page
    if current_user.nil?
      set_flash_error
      redirect_to new_user_session_path
      return
    end

    unless current_user.try(:can_view_admin_panel?)
      set_flash_error
      redirect_to root_path
    end
  end

  def set_flash_error
    flash[:error] = 'Nie masz uprawnień do wykonania tej akcji'
  end
end

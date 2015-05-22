class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :check_if_can_view_page


  protected

  def check_if_can_view_page
    unless current_user.try(:can_view_admin_panel?)
      flash[:error] = 'Nie masz uprawnień do wykonania tej akcji'
      redirect_to root_path
    end
  end
end

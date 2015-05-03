class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :check_if_can_view_page

  rescue_from CanCan::AccessDenied do
    flash[:error] = 'Nie masz uprawnień do wykonania tej akcji'
    redirect_to root_url
  end

  protected

  def check_if_can_view_page
    unless current_user.try(:can_view_admin_panel?)
      puts 'asdsa'
      flash[:error] = 'Nie masz uprawnień do wykonania tej akcji'
      redirect_to root_url
    end
  end
end

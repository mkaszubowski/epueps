class Admin::BaseController < ApplicationController
  layout 'admin'

  check_authorization

  rescue_from CanCan::AccessDenied do
    flash[:error] = 'Nie masz uprawnień do wykonania tej akcji'
    redirect_to root_url
  end
end

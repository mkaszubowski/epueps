class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    puts 'rescue'
    flash[:error] = 'Nie masz uprawnień do wykonania tej akcji'
    redirect_to root_path
  end

end

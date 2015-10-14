module Admin


  def authenticate_admin

    unless current_user && current_user.can_view_admin_panel?
      flash[:error] = "Nie masz uprawnień do wykonania tej akcji"
      redirect_to root_path
    end
  end

end

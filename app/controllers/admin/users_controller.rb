module Admin
  class UsersController < BaseController
    load_and_authorize_resource

    def new
      @user = User.new
    end

    def create
      @user = User.create(user_params)

      if @user.save
        flash[:success] = 'Utworzono użytkownika'
        redirect_to admin_users_path
      else
        flash[:error] = 'Wystąpił błąd'
        render 'new'
      end
    end

    def index
      @users = SortAndFilterData.call(User, params)

      unless @users.any?
        redirect_to admin_users_path, notice: 'Nie znaleziono użytkownika'
      end

      @search_params = params[:search]
    end


    def destroy
      @user = User.find(params[:id])
      if @user.destroy
        flash[:success] = 'Usunięto profil użytkownika'
        redirect_to :back
      else
        flash[:error] = 'Wystąpił błąd, spróbuj ponownie'
      end
    end

    protected

    def user_params
      params.require(:user).permit(:email, :password, :role)
    end

  end
end

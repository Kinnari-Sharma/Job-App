class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:index, :destroy]
  

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @jobs = @user.jobs.paginate(page: params[:page])
    @post_vacancies = @user.post_vacancies.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user, flash: { success: "Welcome! #{@user.name}" }
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(update_params)
      redirect_to @user, flash: { success: "Update Successful!" }
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, flash: { success: "User deleted" }
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :role, :password,
                                   :password_confirmation)
    end

    def update_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :resume)
    end


    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        redirect_to login_url, flash: { danger: "Please log in." }
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.role == "admin"
    end

end

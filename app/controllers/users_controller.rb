class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user,   only: [:edit, :update]
  before_action :if_logged_in, only: [:new, :create]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @jobs = @user.jobs.paginate(page: params[:page])
    @applieds = Applied.where(user_id: params[:id]).to_a
    @applied_jobs = []
    @applieds.each do |a|
      @applied_jobs.append(Job.find_by(id: a.job_id))
    end
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
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def update_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :resume)
    end

    def if_logged_in
      if logged_in?
        redirect_to current_user, flash: { warning: "Already logged in!" }
      end
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

end

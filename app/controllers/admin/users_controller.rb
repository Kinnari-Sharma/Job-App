module Admin
	class UsersController < ApplicationController
		
		before_action :admin_user,     only: [:index, :destroy]
		before_action :logged_in_user, only: [:index, :destroy]

		def index
    	@users = User.paginate(page: params[:page])
  	end
  	
  	def destroy
    	User.find(params[:id]).destroy
    	redirect_to admin_users_url, flash: { success: "User deleted" }
  	end

    def show
      @user = current_user
    end
  
    def edit
      @user = current_user
    end

    def update
      @user = current_user

      if @user.update_attributes(update_params)
        redirect_to admin_user_path(@user), flash: { success: "Update Successful!" }
      else
        render 'edit'
      end
    end

  private

  	def logged_in_user
      unless logged_in?
        redirect_to login_url, flash: { danger: "Please log in." }
      end
    end

    def update_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  end

end
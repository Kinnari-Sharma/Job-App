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
  
  private

  	def logged_in_user
      unless logged_in?
        redirect_to login_url, flash: { danger: "Please log in." }
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  end

end
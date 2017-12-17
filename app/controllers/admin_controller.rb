class AdminController < ApplicationController
	before_action :logged_in
	before_action :admin_user
	
  def show
    @jobs = Job.paginate(page: params[:page])
    @categories = Category.all
    @category = Category.new
    @jobtypes = Jobtype.all
    @jobtype = Jobtype.new
  end

  private
    def logged_in
    	unless logged_in?
    		redirect_to login_url, flash: { danger: "Please Log in!" }
    	end
    end

    def admin_user
    	unless current_user.role == "admin"
  	  	redirect_to current_user, flash: { danger:  "Access Denied!" }
  	  end
    end
end

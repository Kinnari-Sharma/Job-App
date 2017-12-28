module Admin
	class JobsController < ApplicationController
		before_action :logged_in_user
		before_action :admin?

		def update
	    @job = Job.find(params[:id])
	    @job.update_attribute(:approved, true)
	    redirect_to admin_path
	  end

	  def destroy
    	Job.find(params[:id]).destroy
    	redirect_to root_url, flash: { success: "Job Deleted Successfully!" }
  	end

  	private

  	def admin?
      unless current_user.admin?
        redirect_to current_user, flash: { warning: "Access Denied!" }
      end
    end

    def logged_in_user
      unless logged_in?
        redirect_to login_path, flash: { warning: "Please Log In!" }
      end
    end


	end
end
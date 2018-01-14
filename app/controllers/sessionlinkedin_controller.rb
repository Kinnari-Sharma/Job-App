class SessionlinkedinController < ApplicationController
	
	def create
	  begin
	    user = User.from_omniauth(request.env['omniauth.auth'])
	    log_in user
	    if user.admin?
	    	redirect_to admin_path, flash: { success: "Welcome, #{user.name}!" }
	    else
		    redirect_to user, flash: { success: "Welcome, #{user.name}!" }
		  end
	  rescue
	    flash[:warning] = "There was an error while trying to authenticate you..."
	    redirect_to root_path	
	  end
	end

	def destroy
    log_out if logged_in?
    redirect_to root_url
  end
	
	def failure
	  redirect_to login_path
	end
end

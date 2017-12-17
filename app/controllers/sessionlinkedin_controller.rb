class SessionlinkedinController < ApplicationController
	def create
	#	render html: request.env['omniauth.auth'].to_yaml and return
	  begin
	    user = User.from_omniauth(request.env['omniauth.auth'])
	    log_in user
	    redirect_to user, flash: { success: "Welcome, #{user.name}!" }
	  rescue
	    flash[:warning] = "There was an error while trying to authenticate you..."
	    redirect_to root_path	
	  end
	end

	def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

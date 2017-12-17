class SessionsController < ApplicationController
  before_action :if_logged_in, only: :new
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      if user.role == 'admin'
        redirect_to admin_path
      else
        redirect_to user
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  

  private
    def if_logged_in
      if logged_in?
        redirect_to current_user, flash: { warning: "Already logged in!" }
      end
    end
end
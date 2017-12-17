class GeneralPagesController < ApplicationController
  def home
  	@users = User.paginate(page: params[:page])
  	@jobs = Job.paginate(page: params[:page])
    @user = current_user
    @categories = Category.all
    @category = Category.new
    @jobtypes = Jobtype.all
    @jobtype = Jobtype.new
  end

  def help
  end

  def about
  end

  def contact
  end
end

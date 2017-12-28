class GeneralPagesController < ApplicationController
 
  def home
  	@users = User.paginate(page: params[:page])
    @user = current_user
    if @user && current_user.admin?
      @jobs = Job.paginate(page: params[:page])
    else
      @jobs = Job.where(approved: true).paginate(page: params[:page])
    end
    @categories = Category.all
    @category = Category.new
    @jobtypes = Jobtype.all
    @jobtype = Jobtype.new
    if @user && !(@user.admin?)
      @applieds = Applied.where(user_id: current_user.id).to_a
      @applied_jobs = []
      @applieds.each do |a|
        @applied_jobs.append(Job.find_by(id: a.job_id))
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end

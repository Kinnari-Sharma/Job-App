class GeneralPagesController < ApplicationController
 
  def home
    if current_user && current_user.admin?
      redirect_to admin_path
    else
      @user = current_user
      @categories = Category.all
      @jobtypes = Jobtype.all
      if @user
        @jobs = Job.where(approved: true).paginate(page: params[:page])
        @applieds = Applied.where(user_id: current_user.id).to_a
        @applied_jobs = []
        @applieds.each do |a|
          @applied_jobs.append(Job.find_by(id: a.job_id))
        end
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

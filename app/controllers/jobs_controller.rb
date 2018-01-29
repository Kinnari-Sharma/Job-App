class JobsController < ApplicationController
before_action :logged_in_user
before_action :correct_user, only: [:edit, :update, :destroy]
before_action :check_status, only: [:show]
before_action :get_job, only: [:show, :edit, :destroy, :update]
before_action :approved_job, only: [:edit, :update]


  def new
  	@job = current_user.jobs.build
  end

  def create
  	@job = current_user.jobs.build(job_params)
  	if @job.save
  		redirect_to @job, flash: { success: "Job Posted Successfully" }
  	else
  		render 'new'
  	end
  end


  def show
    @applied = Applied.new
    @applicants_ids = Applied.where(job_id: params[:id])
    @applicants = []
    @applicants_ids.each do |applicant|
      @applicants.append(User.find(applicant.user_id))
    end
  end
  
  def index
      
    @jobs = Job.search(params[:search], params[:search_location], params[:category]).
                                        order("created_at DESC").where(approved: true).
                                        paginate(page: params[:page])
  end

  def destroy
    @job.destroy
    redirect_to current_user, flash: { success: "Job Deleted Successfully!" }
  end

  def edit
  end

  def update
    if @job.update_attributes(update_params)
      redirect_to @job
    else
      render 'edit'
    end
  end

  private
    def job_params
    	params.require(:job).permit(:title, :description, :sector,
    														  :jobtype, :cname, :url, :contactmail, :location)
    end

    def logged_in_user
      unless logged_in?
        redirect_to login_path, flash: { warning: "Please Log In!" }
      end
    end
    
    def update_params
      params.require(:job).permit(:title, :description, :sector,
                                  :jobtype, :cname, :url, :contactmail, :location)
    end

    def get_job
      @job = Job.find(params[:id])
    end

    def approved_job
      if @job.approved?
        redirect_to @job, flash: { message: "Your job is approved by admin. No changes required!" }
      end
    end

    def correct_user
      get_job
      unless helpers.correct_user?(@job)
        redirect_to current_user, flash: {warning: "You are not authorized for this action" }
      end
    end

    def check_status
      get_job
      unless helpers.correct_user?(@job) || @job.approved?
        redirect_to root_path, flash: { warning: "Invalid Job" }
      end
    end

end

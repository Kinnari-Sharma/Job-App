class JobsController < ApplicationController
before_action :logged_in_user
 
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
  	@job = Job.find(params[:id])
    @applied = Applied.new
    @applicants_ids = Applied.where(job_id: params[:id])
    @applicants = []
    @applicants_ids.each do |applicant|
      @applicants.append(User.find(applicant.user_id))
    end
  end
  
  def index
      
    @jobs = Job.search(params[:search], params[:search_location], params[:category]).
                                           order("created_at DESC").
                                           paginate(page: params[:page])
  end



  private
    def job_params
    	params.require(:job).permit(:title, :description, :sector,
    														  :jobtype, :cname, :url, :contactmail, :location)
    end

    def update_params
      params.require(:job).permit(:approved_by)
    end

    def logged_in_user
      unless logged_in?
        redirect_to login_path, flash: { warning: "Please Log In!" }
      end
    end


    
end

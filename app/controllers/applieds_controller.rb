class AppliedsController < ApplicationController

#  def new
 # 	@applied = Applied.new
  #end

	def create
		@applied = Applied.new(applied_params)
		if @applied.save
			redirect_to job_path(params[:applied][:job_id]), flash: {success: "Successfully Applied for the job" }
		else
			render job_path(params[:applied][:id]), flash: { danger: "Cannot Apply" }
		end
	end
 
  def update
 	  @applied = Applied.find(params[:id])
 	  if @applied.update_attribute(:apply, true)
 	  	job = Job.find(@applied.job_id)
 	  	user = User.find(@applied.user_id)
 		  UserMailer.acceptance_mail(user, job).deliver_now
      redirect_to job, flash: { info: "Email sent!" }
    end
  end
	

	private
	  def applied_params
	  	params.require(:applied).permit(:job_id, :user_id)
	  end
end
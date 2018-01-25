module Admin
	class JobtypesController < ApplicationController
		before_action :admin?

		def create
			@jobtype = Jobtype.new(jobtype_params)

			if @jobtype.save
				redirect_to admin_path, flash: { success: "Jobtype added!" }
			else
				redirect_to admin_path, flash: { warning: "Jobtype invalid!" }
			end

		end


		def destroy
			@jobtype = Jobtype.find(params[:id])
			@jobtype.destroy
			
			redirect_to admin_url, flash: { success: "Job type removed!" }
		end

		private
		  def jobtype_params
		  	params.require(:jobtype).permit(:jobtype)
		  end

		  def admin?
      	unless current_user.admin?
        	redirect_to current_user, flash: { warning: "Access Denied!" }
      	end
    	end
	end
end
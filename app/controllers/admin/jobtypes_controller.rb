module Admin
	class JobtypesController < ApplicationController

		def create
			@jobtype = Jobtype.new(jobtype_params)

			if @jobtype.save
				redirect_to root_path, flash: { success: "Jobtype added!" }
			else
				redirect_to root_path, flash: { warning: "Jobtype invalid!" }
			end

		end


		def destroy
			@jobtype = Jobtype.find(params[:id])
			@jobtype.destroy
			
			redirect_to root_url, flash: { success: "Job type removed!" }
		end

		private
		  def jobtype_params
		  	params.require(:jobtype).permit(:jobtype)
		  end
	end
end
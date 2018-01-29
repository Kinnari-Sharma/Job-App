module Admin
	class JobtypesController < ApplicationController
		before_action :admin?
		before_action :find_type, except: :create

		def create
			@jobtype = Jobtype.new(jobtype_params)

			if @jobtype.save
				redirect_to admin_path, flash: { success: "Jobtype added!" }
			else
				redirect_to admin_path, flash: { warning: "Jobtype invalid!" }
			end

		end

		def destroy
			@jobtype.destroy
			redirect_to admin_url, flash: { success: "Job type removed!" }
		end

		def edit
		end

		def update
			if @jobtype.update_attributes(update_params)
				redirect_to admin_path, flash: { success: "Jobtype Updated!" }
			else
				redirect_to edit_admin_jobtype_path, flash: { warning: "Jobtype invalid" }
			end
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

    	def update_params
    		params.require(:jobtype).permit(:jobtype)
    	end

    	def find_type
    		@jobtype = Jobtype.find(params[:id])
    	end
	end
end
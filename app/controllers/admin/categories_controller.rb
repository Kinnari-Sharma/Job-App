module Admin
	class CategoriesController < ApplicationController
		before_action :admin?
		before_action :find_category, except: :create

		def create
			@category = Category.new(category_params)
			if @category.save
				redirect_to admin_path, flash: { success: "Sector added!" }
			else
				redirect_to admin_path, flash: { success: "Invalid Sector!" }
			end

		end

		def destroy
			@category.destroy
			redirect_to admin_url, flash: { success: "Category removed!" }
		end

		def edit
		end

		def update
			if @category.update_attributes(update_params)
				redirect_to admin_path, flash: { success: "Sector Updated!" }
			else
				redirect_to edit_admin_category_path, flash: { warning: "Invalid Sector" }
			end

		end

		private
		  def category_params
		  	params.require(:category).permit(:job_category)
		  end

		  def admin?
      	unless current_user.admin?
        	redirect_to current_user, flash: { warning: "Access Denied!" }
      	end
    	end

    	def update_params
    		params.require(:category).permit(:job_category)
    	end

    	def find_category
    		@category = Category.find(params[:id])
    	end
	end
end
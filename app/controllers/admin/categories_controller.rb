module Admin
	class CategoriesController < ApplicationController


		def create
			@category = Category.new(category_params)
			if @category.save
				redirect_to admin_path, flash: { success: "Sector added!" }
			else
				redirect_to admin_path, flash: { success: "Invalid Sector!" }
			end

		end

		def destroy
			@category = Category.find(params[:id])
			@category.destroy
			redirect_to admin_url, flash: { success: "Category removed!" }
		end

		private
		  def category_params
		  	params.require(:category).permit(:job_category)
		  end
	end
end
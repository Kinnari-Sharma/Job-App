class PostVacanciesController < ApplicationController
  before_action :logged_in_user
  before_action :jobseeker?, only: [:new, :create]
  
  def new
  	@postvacancy = current_user.post_vacancies.build
  end

  def create
  	@postvacancy = current_user.post_vacancies.build(vacancy_params)
  	if @postvacancy.save
  		redirect_to current_user, flash: { success: "Vacancy Posted Successfully!" }
  	else
  		render 'new'
  	end
  end
  
  def show
    @post_vacancy = PostVacancy.find(params[:id])
  end

  def destroy
    PostVacancy.find(params[:id]).destroy
    redirect_to post_vacancy.user, flash: { success: "Post deleted successfully!" }
  end

  private
    def vacancy_params
    	params.require(:post_vacancy).permit(:name, :category, :description,
    																			:phone, :city)
    end

    def logged_in_user
      unless logged_in? 
        redirect_to login_path, flash: { warning:  "Please Log In!" }
      end
    end

    def jobseeker?
      unless current_user.role == "job-seeker"
        redirect_to current_user, flash: { warning: "Unauthorized Access!" }
      end
    end
end

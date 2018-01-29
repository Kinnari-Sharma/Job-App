[1mdiff --git a/app/assets/stylesheets/custom.scss b/app/assets/stylesheets/custom.scss[m
[1mindex afc3724..f473706 100644[m
[1m--- a/app/assets/stylesheets/custom.scss[m
[1m+++ b/app/assets/stylesheets/custom.scss[m
[36m@@ -291,7 +291,7 @@[m [mdiv.search{[m
   margin: 10px;[m
   padding: 10px;[m
   .categories{[m
[31m-    margin-top: 20px;[m
[32m+[m[32m    margin-top: 5px;[m
     text-align:center;[m
     li{[m
     list-style: none;[m
[1mdiff --git a/app/controllers/admin/categories_controller.rb b/app/controllers/admin/categories_controller.rb[m
[1mindex c41bb4e..77aa2d2 100644[m
[1m--- a/app/controllers/admin/categories_controller.rb[m
[1m+++ b/app/controllers/admin/categories_controller.rb[m
[36m@@ -1,6 +1,7 @@[m
 module Admin[m
 	class CategoriesController < ApplicationController[m
 		before_action :admin?[m
[32m+[m		[32mbefore_action :find_category, except: :create[m
 [m
 		def create[m
 			@category = Category.new(category_params)[m
[36m@@ -13,11 +14,22 @@[m [mmodule Admin[m
 		end[m
 [m
 		def destroy[m
[31m-			@category = Category.find(params[:id])[m
 			@category.destroy[m
 			redirect_to admin_url, flash: { success: "Category removed!" }[m
 		end[m
 [m
[32m+[m		[32mdef edit[m
[32m+[m		[32mend[m
[32m+[m
[32m+[m		[32mdef update[m
[32m+[m			[32mif @category.update_attributes(update_params)[m
[32m+[m				[32mredirect_to admin_path, flash: { success: "Sector Updated!" }[m
[32m+[m			[32melse[m
[32m+[m				[32mredirect_to edit_admin_category_path, flash: { warning: "Invalid Sector" }[m
[32m+[m			[32mend[m
[32m+[m
[32m+[m		[32mend[m
[32m+[m
 		private[m
 		  def category_params[m
 		  	params.require(:category).permit(:job_category)[m
[36m@@ -28,5 +40,13 @@[m [mmodule Admin[m
         	redirect_to current_user, flash: { warning: "Access Denied!" }[m
       	end[m
     	end[m
[32m+[m
[32m+[m[41m    [m	[32mdef update_params[m
[32m+[m[41m    [m		[32mparams.require(:category).permit(:job_category)[m
[32m+[m[41m    [m	[32mend[m
[32m+[m
[32m+[m[41m    [m	[32mdef find_category[m
[32m+[m[41m    [m		[32m@category = Category.find(params[:id])[m
[32m+[m[41m    [m	[32mend[m
 	end[m
 end[m
\ No newline at end of file[m
[1mdiff --git a/app/controllers/admin/jobs_controller.rb b/app/controllers/admin/jobs_controller.rb[m
[1mindex 10d122f..3de1ef5 100644[m
[1m--- a/app/controllers/admin/jobs_controller.rb[m
[1m+++ b/app/controllers/admin/jobs_controller.rb[m
[36m@@ -22,6 +22,7 @@[m [mmodule Admin[m
 [m
 		def update[m
       @job.update_attributes(update_params) [m
[32m+[m[32m      @job.update_attribute(:approved_by, current_user.name)[m
 	    redirect_to admin_path[m
 	  end[m
 [m
[1mdiff --git a/app/controllers/admin/jobtypes_controller.rb b/app/controllers/admin/jobtypes_controller.rb[m
[1mindex 6158fe2..14f3fb7 100644[m
[1m--- a/app/controllers/admin/jobtypes_controller.rb[m
[1m+++ b/app/controllers/admin/jobtypes_controller.rb[m
[36m@@ -1,6 +1,7 @@[m
 module Admin[m
 	class JobtypesController < ApplicationController[m
 		before_action :admin?[m
[32m+[m		[32mbefore_action :find_type, except: :create[m
 [m
 		def create[m
 			@jobtype = Jobtype.new(jobtype_params)[m
[36m@@ -13,14 +14,22 @@[m [mmodule Admin[m
 [m
 		end[m
 [m
[31m-[m
 		def destroy[m
[31m-			@jobtype = Jobtype.find(params[:id])[m
 			@jobtype.destroy[m
[31m-			[m
 			redirect_to admin_url, flash: { success: "Job type removed!" }[m
 		end[m
 [m
[32m+[m		[32mdef edit[m
[32m+[m		[32mend[m
[32m+[m
[32m+[m		[32mdef update[m
[32m+[m			[32mif @jobtype.update_attributes(update_params)[m
[32m+[m				[32mredirect_to admin_path, flash: { success: "Jobtype Updated!" }[m
[32m+[m			[32melse[m
[32m+[m				[32mredirect_to edit_admin_jobtype_path, flash: { warning: "Jobtype invalid" }[m
[32m+[m			[32mend[m
[32m+[m		[32mend[m
[32m+[m
 		private[m
 		  def jobtype_params[m
 		  	params.require(:jobtype).permit(:jobtype)[m
[36m@@ -31,5 +40,13 @@[m [mmodule Admin[m
         	redirect_to current_user, flash: { warning: "Access Denied!" }[m
       	end[m
     	end[m
[32m+[m
[32m+[m[41m    [m	[32mdef update_params[m
[32m+[m[41m    [m		[32mparams.require(:jobtype).permit(:jobtype)[m
[32m+[m[41m    [m	[32mend[m
[32m+[m
[32m+[m[41m    [m	[32mdef find_type[m
[32m+[m[41m    [m		[32m@jobtype = Jobtype.find(params[:id])[m
[32m+[m[41m    [m	[32mend[m
 	end[m
 end[m
\ No newline at end of file[m
[1mdiff --git a/app/controllers/conversations_controller.rb b/app/controllers/conversations_controller.rb[m
[1mindex a5a3185..f821a3c 100644[m
[1m--- a/app/controllers/conversations_controller.rb[m
[1m+++ b/app/controllers/conversations_controller.rb[m
[36m@@ -3,7 +3,7 @@[m [mclass ConversationsController < ApplicationController[m
 [m
 	def index[m
 		@users = User.all[m
[31m-		@conversations = Conversation.all[m
[32m+[m		[32m@conversations = Conversation.all.order("created_at DESC")[m
 	end[m
 [m
 	def create[m
[1mdiff --git a/app/controllers/jobs_controller.rb b/app/controllers/jobs_controller.rb[m
[1mindex 709bb71..8b63956 100644[m
[1m--- a/app/controllers/jobs_controller.rb[m
[1m+++ b/app/controllers/jobs_controller.rb[m
[36m@@ -1,6 +1,6 @@[m
 class JobsController < ApplicationController[m
 before_action :logged_in_user[m
[31m-before_action :correct_user, except: [:show, :index][m
[32m+[m[32mbefore_action :correct_user, only: [:edit, :update, :destroy][m
 before_action :check_status, only: [:show][m
 before_action :get_job, only: [:show, :edit, :destroy, :update][m
 before_action :approved_job, only: [:edit, :update][m
[36m@@ -32,8 +32,8 @@[m [mbefore_action :approved_job, only: [:edit, :update][m
   def index[m
       [m
     @jobs = Job.search(params[:search], params[:search_location], params[:category]).[m
[31m-                                           order("created_at DESC").[m
[31m-                                           paginate(page: params[:page])[m
[32m+[m[32m                                        order("created_at DESC").where(approved: true).[m
[32m+[m[32m                                        paginate(page: params[:page])[m
   end[m
 [m
   def destroy[m
[1mdiff --git a/app/helpers/application_helper.rb b/app/helpers/application_helper.rb[m
[1mindex 3006056..d74eea7 100644[m
[1m--- a/app/helpers/application_helper.rb[m
[1m+++ b/app/helpers/application_helper.rb[m
[36m@@ -11,4 +11,18 @@[m [mmodule ApplicationHelper[m
       page_title + " | " + base_title[m
     end[m
   end[m
[32m+[m
[32m+[m[32m  def custom_form(object, path, label_name, name, submit_name)[m[41m    [m
[32m+[m[32m    form_for object, url: path do |f|[m
[32m+[m[32m      result = capture do[m
[32m+[m[32m        tag.div class: "form-group" do[m
[32m+[m[32m          concat f.label name, label_name[m
[32m+[m[32m          concat f.text_field name, class: "form-control"[m
[32m+[m[32m        end[m
[32m+[m[32m      end[m
[32m+[m[32m      result += f.submit submit_name, class: "btn-primary form-control"[m
[32m+[m[32m    end[m
[32m+[m[32m  end[m
[32m+[m
 end[m
[41m+[m
[1mdiff --git a/app/models/conversation.rb b/app/models/conversation.rb[m
[1mindex 48ce5ae..91d0e6b 100644[m
[1m--- a/app/models/conversation.rb[m
[1m+++ b/app/models/conversation.rb[m
[36m@@ -1,6 +1,7 @@[m
 class Conversation < ApplicationRecord[m
 	belongs_to :sender, foreign_key: :sender_id, class_name: 'User'[m
 	belongs_to :recipent, foreign_key: :recipent_id, class_name: 'User'[m
[32m+[m	[32mbelongs_to :job[m
 	[m
 	has_many :messages, dependent: :destroy[m
 [m
[1mdiff --git a/app/models/job.rb b/app/models/job.rb[m
[1mindex 25ea265..f4c3ce1 100644[m
[1m--- a/app/models/job.rb[m
[1m+++ b/app/models/job.rb[m
[36m@@ -2,6 +2,7 @@[m [mclass Job < ApplicationRecord[m
 [m
 	belongs_to :user[m
   has_many :applieds, dependent: :destroy[m
[32m+[m[32m  has_many :conversations, dependent: :destroy[m
 [m
 	default_scope -> { order(created_at: :desc) }[m
 [m
[36m@@ -31,7 +32,6 @@[m [mclass Job < ApplicationRecord[m
   	unless category.blank?[m
   		jobs = jobs.where("sector LIKE ?", "#{category}")[m
   	end[m
[31m-    jobs = jobs.where(approved: true)[m
   	return jobs[m
   end[m
 [m
[1mdiff --git a/app/views/admin/_home.html.erb b/app/views/admin/_home.html.erb[m
[1mindex 4ea2459..558116c 100644[m
[1m--- a/app/views/admin/_home.html.erb[m
[1m+++ b/app/views/admin/_home.html.erb[m
[36m@@ -6,45 +6,44 @@[m
 [m
 	<div class="col-md-4">[m
 		<div class = "category">[m
[31m-			<h3 class="center">Edit Job Sectors</h3>[m
[32m+[m			[32m<h3 class="center">Job Sectors</h3>[m
 			<% unless @categories.nil? %>[m
 				<ul class="categories">[m
 					<% @categories.each do |c| %>[m
[31m-					  <li><%= c.job_category %> <%=link_to "delete", admin_category_path(c),[m
[32m+[m					[32m  <li><%= c.job_category %>[m
[32m+[m					[41m  [m		[32m<%= link_to "Edit", edit_admin_category_path(c) %>[m
[32m+[m							[32m  <%=link_to "Delete", admin_category_path(c),[m
 					  																			method: :delete,[m
[31m-					  																		  data: {confirm: "Are you sure?"} %></li>[m
[32m+[m					[41m  [m																		[32m  data: {confirm: "Are you sure?"} %>[m
[32m+[m					[41m  [m																		[32m  </li>[m
 						[m
 					<% end %>[m
 [m
 				</ul>[m
 			<% end %>[m
[31m-			<%= form_for @category, url: admin_categories_path do |f| %>[m
[31m-			  <div class = "form-group" >[m
[31m-					<%= f.label :job_category, "Job Sector: " %>[m
[31m-			  	<%= f.text_field :job_category, class: "form-control" %>[m
[31m-				</div>[m
[31m-			  <%= f.submit "Add", class: "btn-primary form-control" %>[m
[31m-			<% end %>[m
[32m+[m[41m			[m
[32m+[m
[32m+[m			[32m<%= custom_form(@category, admin_categories_path, "Job Sector", "job_category", "Add") %>[m
[32m+[m[41m			[m
 		</div>[m
 [m
 		<div class = "category">[m
[31m-			<h3 class="center">Edit Job Type</h3>[m
[32m+[m			[32m<h3 class="center">Job Types</h3>[m
 			<% unless @jobtypes.nil? %>[m
 				<ul class="categories">[m
 					<% @jobtypes.each do |j| %>[m
[31m-					  <li><%= j.jobtype %> <%=link_to "delete", admin_jobtype_path(j),[m
[32m+[m					[32m  <li><%= j.jobtype %>[m[41m [m
[32m+[m					[41m  [m		[32m<%= link_to "Edit", edit_admin_jobtype_path(j) %>[m
[32m+[m					[41m  [m		[32m<%=link_to "Delete", admin_jobtype_path(j),[m
 					  																			method: :delete,[m
[31m-					  																		  data: {confirm: "Are you sure?"} %></li>[m
[32m+[m					[41m  [m																		[32m  data: {confirm: "Are you sure?"} %>[m[41m									[m
[32m+[m					[32m  </li>[m
 					<% end %>[m
 				</ul>[m
 			<% end %>[m
[31m-			<%= form_for @jobtype, url: admin_jobtypes_path do |f| %>[m
[31m-			  <div class = "form-group" >[m
[31m-					<%= f.label :jobtype, "Job Type: " %>[m
[31m-			  	<%= f.text_field :jobtype, class: "form-control" %>[m
[31m-				</div>[m
[31m-			  <%= f.submit "Add", class: "btn-primary form-control" %>[m
[31m-			<% end %>[m
[31m-			</div>[m
[32m+[m[41m			[m
[32m+[m			[32m<%= custom_form(@jobtype, admin_jobtypes_path, "Job Type ", "jobtype", "Add" ) %>[m
[32m+[m[41m			[m
[32m+[m		[32m</div>[m
 	</div>[m
 </div>[m
\ No newline at end of file[m
[1mdiff --git a/app/views/admin/jobs/index.html.erb b/app/views/admin/jobs/index.html.erb[m
[1mindex cdc0c41..631e3f1 100644[m
[1m--- a/app/views/admin/jobs/index.html.erb[m
[1m+++ b/app/views/admin/jobs/index.html.erb[m
[36m@@ -10,8 +10,5 @@[m
 			<h1 class="center">Jobs</h1>[m
   		<%= render 'admin/jobs/jobs' %>[m
   	</div>[m
[31m-  	<div class="col-md-3">[m
[31m-  		[m
[31m-  	</div>[m
   </div>[m
 <% end %>[m
[1mdiff --git a/app/views/admin/jobs/show.html.erb b/app/views/admin/jobs/show.html.erb[m
[1mindex 84e1910..32866e1 100644[m
[1m--- a/app/views/admin/jobs/show.html.erb[m
[1m+++ b/app/views/admin/jobs/show.html.erb[m
[36m@@ -10,7 +10,7 @@[m
 																						admin_user_path(@job.user) %> <br>			[m
 			[m
 			<% if @job.approved? %>		  														[m
[31m-				<%= reject_link(@job) %>[m
[32m+[m				[32mApproved <%= reject_link(@job) %>[m
 		  <% else %>[m
 		  	<% if @job.approved.nil? %>[m
    		    <span>Not yet approved! <%= approve_link(@job) %> </span> [m
[1mdiff --git a/config/routes.rb b/config/routes.rb[m
[1mindex 94c4ae1..bacebe0 100644[m
[1m--- a/config/routes.rb[m
[1m+++ b/config/routes.rb[m
[36m@@ -11,8 +11,8 @@[m [mRails.application.routes.draw do[m
   delete '/logout',  to: 'sessions#destroy'[m
   get '/admin', to: 'admin#home'[m
   namespace :admin do[m
[31m-    resources :categories, only: [ :create, :destroy][m
[31m-    resources :jobtypes, only: [ :create, :destroy][m
[32m+[m[32m    resources :categories, except: [:new, :show, :index][m
[32m+[m[32m    resources :jobtypes, except: [:new, :show, :index][m
     resources :users, except: [:new, :create][m
     resources :jobs, only: [:destroy, :update, :show, :index][m
   end[m

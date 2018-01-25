module JobsHelper
	def approve_link(job)
		link_to "approve", admin_job_path(job, approved: true),
		    														 			method: :patch, class: "review"
	end

	def reject_link(job)
		link_to "reject", admin_job_path(job, approved: false),
		    																	 method: :patch, class: "review"
	end

	def correct_user?(job)
		if current_user.id == job.user_id
			return true
		else
			return false
		end
	end
end
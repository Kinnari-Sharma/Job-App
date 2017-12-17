module AppliedsHelper
	def applied(job_id, user_id)
		unless Applied.where(job_id: job_id, user_id: user_id).empty?
			return true
		end
	end

end

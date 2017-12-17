class Category < ApplicationRecord
	validates :job_category, presence: true,
													 uniqueness: { case_sensitive: false }
end

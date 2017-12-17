class Jobtype < ApplicationRecord
	validates :jobtype, presence: true,
													 uniqueness: { case_sensitive: false }
end

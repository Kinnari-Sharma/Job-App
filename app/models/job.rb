class Job < ApplicationRecord

	belongs_to :user

	default_scope -> { order(created_at: :desc) }

	validates :cname, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :contactmail, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :location, presence: true
  validates :title, presence: true
	validates :url, presence: true
	validates :user_id, presence: true


  def self.search(search, search_location, category)
  	jobs = Job.all

  	unless search.empty?
  		jobs = jobs.where("(title LIKE ?) OR (jobtype LIKE ?) OR (sector LIKE ?) OR (cname LIKE ?)",
  										"%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  	end
  	unless search_location.blank?
  		jobs = jobs.where("location LIKE ?", "%#{search_location}%")
  	end
  	unless category.blank?
  		jobs = jobs.where("sector LIKE ?", "#{category}")
  	end
    jobs = jobs.where(approved: true)
  	return jobs
  end

end

class PostVacancy < ApplicationRecord
	belongs_to :user

	default_scope -> { order(created_at: :desc) }

	validates :city, presence: true
	validates :description, presence: true,
													length: {minimum: 40}
	validates :name, presence: true
	validates :phone, presence: true,
										length: {is: 10},
										numericality: true
	
end

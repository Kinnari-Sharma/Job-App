class Conversation < ApplicationRecord
	belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
	belongs_to :recipent, foreign_key: :recipent_id, class_name: 'User'
	belongs_to :job
	
	has_many :messages, dependent: :destroy

	validates_uniqueness_of :sender_id, scope: [:recipent_id, :job_id]

	scope :between, -> ( sender_id, recipent_id, job_id ) do
		where("(((conversations.sender_id = ? AND conversations.recipent_id = ?) OR
			      (conversations.sender_id = ? AND conversations.recipent_id = ?)) AND 
			      (conversations.job_id = ?))",
			      sender_id, recipent_id, recipent_id, sender_id, job_id )
	end
end

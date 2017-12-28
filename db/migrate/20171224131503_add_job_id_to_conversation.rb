class AddJobIdToConversation < ActiveRecord::Migration[5.1]
  def change
    add_reference :conversations, :job, foreign_key: true
  end
end

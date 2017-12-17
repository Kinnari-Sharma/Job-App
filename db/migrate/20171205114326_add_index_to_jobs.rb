class AddIndexToJobs < ActiveRecord::Migration[5.1]
  def change
  	add_index :jobs, [:user_id, :created_at]
  end
end

class AddApprovedByToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :approved_by, :string
  end
end

class AddApprovedToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :approved, :boolean, default: false
  end
end

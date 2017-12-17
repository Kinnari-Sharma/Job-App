class CreateApplieds < ActiveRecord::Migration[5.1]
  def change
    create_join_table :jobs, :users, table_name: :applieds do |t|
    	t.index [:job_id, :user_id], unique: true

      t.timestamps
    end
  end
end

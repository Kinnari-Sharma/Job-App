class CreateJobtypes < ActiveRecord::Migration[5.1]
  def change
    create_table :jobtypes do |t|
      t.string :jobtype

      t.timestamps
    end
  end
end

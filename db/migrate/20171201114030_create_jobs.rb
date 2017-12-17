class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :sector
      t.string :type
      t.string :cname
      t.string :url
      t.string :contactmail

      t.timestamps
    end
  end
end

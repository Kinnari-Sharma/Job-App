class CreatePostVacancies < ActiveRecord::Migration[5.1]
  def change
    create_table :post_vacancies do |t|
      t.string :name
      t.string :category
      t.text :description
      t.string :phone
      t.string :city

      t.timestamps
    end
  end
end

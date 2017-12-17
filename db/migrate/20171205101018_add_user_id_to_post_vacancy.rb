class AddUserIdToPostVacancy < ActiveRecord::Migration[5.1]
  def change
    add_reference :post_vacancies, :user, foreign_key: true
  end
end

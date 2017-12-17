class RemoveTypeFromJob < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :type, :string
  end
end

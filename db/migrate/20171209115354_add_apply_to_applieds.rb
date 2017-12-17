class AddApplyToApplieds < ActiveRecord::Migration[5.1]
  def change
    add_column :applieds, :apply, :boolean, default: false
  end
end

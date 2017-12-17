class AddPrimaryKeyToApplied < ActiveRecord::Migration[5.1]
	def self.up
		add_column :applieds, :id, :primary_key
	end

	def self.down
		remove_column :applieds, :id
	end
end

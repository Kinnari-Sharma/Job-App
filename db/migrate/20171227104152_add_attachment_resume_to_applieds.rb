class AddAttachmentResumeToApplieds < ActiveRecord::Migration[5.1]
  def self.up
    change_table :applieds do |t|
      t.attachment :resume
    end
  end

  def self.down
    remove_attachment :applieds, :resume
  end
end

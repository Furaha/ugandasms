class AddAttachmentFileToCampaigns < ActiveRecord::Migration
  def self.up
    change_table :campaigns do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :campaigns, :file
  end
end

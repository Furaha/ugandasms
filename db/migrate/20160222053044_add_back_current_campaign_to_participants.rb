class AddBackCurrentCampaignToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :current_campaign, :integer
  end
end

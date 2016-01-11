class AddCampaingIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :campaign_id, :integer
  end
end

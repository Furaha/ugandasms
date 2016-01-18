class AddCountersToParticipant < ActiveRecord::Migration
  def change
  	add_column :participants, :question_count, :integer
  	add_column :participants, :current_campaign, :integer
  end
end

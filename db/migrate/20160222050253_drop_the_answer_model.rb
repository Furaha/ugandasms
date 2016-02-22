class DropTheAnswerModel < ActiveRecord::Migration
  def change
    drop_table :answers
    remove_column :participants, :question_count, :integer
    remove_column :participants, :current_campaign, :integer
  end
end

class CreateParticipantAnswers < ActiveRecord::Migration
  def change
    create_table :participant_answers do |t|
      t.integer :participant_id
      t.integer :campaign_id
      t.integer :question_id
      t.integer :option_id

      t.timestamps null: false
    end
  end
end

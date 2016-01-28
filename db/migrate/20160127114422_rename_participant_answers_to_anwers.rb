class RenameParticipantAnswersToAnwers < ActiveRecord::Migration
  def change    
    rename_table :participant_answers, :answers    
  end
end

class RenameParticipantAnswersToAnwers < ActiveRecord::Migration
  def change
    def self.up
      rename_table :participant_answers, :answers
    end

    def self.down
      rename_table :answers, :participant_answers
    end
  end
end

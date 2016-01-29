class ChangeQuestionToQuestionTextInAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :question, :string
    add_column :answers, :question_text, :string
  end
end

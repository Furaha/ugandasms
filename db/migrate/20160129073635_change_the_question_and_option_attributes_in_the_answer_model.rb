class ChangeTheQuestionAndOptionAttributesInTheAnswerModel < ActiveRecord::Migration
  def change
    remove_column :answers, :question_id, :integer
    remove_column :answers, :option_id, :integer
    add_column    :answers, :question, :string
    add_column    :answers, :question_reply, :string
  end
end

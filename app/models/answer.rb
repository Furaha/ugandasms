class Answer < ActiveRecord::Base
  belongs_to :participant
  belongs_to :campaign
  belongs_to :question
  belongs_to :option

  validates :answer_id, presence: true
  validates :campaign_id, presence: true
  validates :question_id, presence: true
  validates :option_id, presence: true
end

class Answer < ActiveRecord::Base
  belongs_to :participant
  belongs_to :campaign

  validates :participant_id, presence: true
  validates :campaign_id, presence: true
  validates :question_text, presence: true
  validates :question_reply, presence: true
end

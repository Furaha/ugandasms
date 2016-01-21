class Option < ActiveRecord::Base
  belongs_to :question
  has_many :participant_answers, dependent: :delete_all
  validates :title, presence: true
  validates :question_id, presence: true
end

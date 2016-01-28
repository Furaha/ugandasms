class Option < ActiveRecord::Base
  belongs_to :question
  has_many :answers
  validates :title, presence: true
  validates :question_id, presence: true
end

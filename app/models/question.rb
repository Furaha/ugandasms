class Question < ActiveRecord::Base
  has_many :options
  validates :title, presence: true
end

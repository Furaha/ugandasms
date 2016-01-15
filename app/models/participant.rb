class Participant < ActiveRecord::Base
  validates :number, presence: true
end

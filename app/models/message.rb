class Message < ActiveRecord::Base
  belongs_to :program

  validates :title, length: { minimum: 4 }
end

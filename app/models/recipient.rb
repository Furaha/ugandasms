class Recipient < ActiveRecord::Base
  belongs_to :program

  validates_presence_of :name, :number
end

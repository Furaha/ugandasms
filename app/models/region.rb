class Region < ActiveRecord::Base
  has_many :programs
  validates :name, presence: true, uniqueness: true
end

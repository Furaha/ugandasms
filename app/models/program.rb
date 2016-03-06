class Program < ActiveRecord::Base
  belongs_to :region

  validates_presence_of :region_id, :name
  validates_uniqueness_of :name

  has_many :messages
  accepts_nested_attributes_for :messages, allow_destroy: true
end

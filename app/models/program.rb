class Program < ActiveRecord::Base
  belongs_to :region

  validates_presence_of :region_id, :name
  validates_uniqueness_of :name
end

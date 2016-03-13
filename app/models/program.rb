class Program < ActiveRecord::Base
  belongs_to :region

  validates_presence_of :region_id, :name

  has_many :messages
  has_many :recipients

  accepts_nested_attributes_for :messages, allow_destroy: true, reject_if: proc { |attributes| attributes['title'].blank?  }
end

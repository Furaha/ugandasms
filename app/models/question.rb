class Question < ActiveRecord::Base
  has_many :options, dependent: :delete_all
  belongs_to :campaign
  validates :title, presence: true
  validates :campaign_id, presence: true
end

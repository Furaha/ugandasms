class Campaign < ActiveRecord::Base
	has_many :questions, dependent: :delete_all
	validates :title, presence: true
end

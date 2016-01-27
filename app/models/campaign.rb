class Campaign < ActiveRecord::Base
  has_attached_file :file,
                    :path => ":rails_root/app/campaigns/:id/:filename",
                    :url => "/campaigns/:id/:filename"
  validates_attachment :file, presence: true,
                              content_type: { content_type: "text/x-yaml"}
  has_many :questions, dependent: :delete_all
  has_many :answers
  validates :title, presence: true
end

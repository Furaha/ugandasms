class Question < ActiveRecord::Base
  has_many :options, dependent: :delete_all
  has_many :answers
  belongs_to :campaign
  validates :title, presence: true
  validates :campaign_id, presence: true

  def message
    @message = "#{self.title}"
    @options = self.options
    if @options.nil?
      return @message
    else
      @option_string = ""
      @counter = 1
      @options.each do |option|
        @option_string << "\n #{@counter}. #{option.title}"
        @counter += 1
      end
      return @message + @option_string
    end
  end
end

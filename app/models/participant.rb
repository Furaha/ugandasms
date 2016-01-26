class Participant < ActiveRecord::Base
  validates :number, presence: true
  has_many :participant_answers, dependent: :delete_all
  def send_message(msg)
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => self.number,
      :body => msg,
    )
    puts message.to
  end

  def track_campaign(campaign_id, question_count)
    self.update(question_count: question_count, current_campaign: campaign_id)    
  end
end

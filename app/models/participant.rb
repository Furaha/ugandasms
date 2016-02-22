class Participant < ActiveRecord::Base
  require 'csv'
  validates :number, presence: true
  has_many :answers

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      participant_hash = row.to_hash
      participant = Participant.where(number: participant_hash["number"])

      if participant.count == 1
        participant.first.update_attributes(participant_hash)
      else
        Participant.create!(participant_hash)
      end # end if !participant.nil?
    end # end CSV.foreach
  end # end self.import(file)

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

  def track_campaign(campaign_id)
    self.update(current_campaign: campaign_id)    
  end  

  def tracked_campaign
    if self.current_campaign.nil?
      return nil
    else
      return Campaign.find(self.current_campaign)
    end
  end
  
  def campaign_is_tracked?(campaign_record_id)
    if (!self.tracked_campaign.nil? && (self.tracked_campaign.id == campaign_record_id))
      true
    else
      false
    end
  end
end

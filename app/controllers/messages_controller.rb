class MessagesController < ApplicationController
  require 'twilio-ruby' 


  #  def start_campaign
  #    @campaign = Campaign.find(params[:campaign_id])
  #    @question_one = @campaign.questions.first
  #    @participants = Participant.all
  #    @participants.each do |participant|
  #      if !participant.campaign_is_tracked?(@campaign.id)
  #        participant.send_message(@question_one.message)
  #        participant.track_campaign(@campaign.id)
  #      end
  #    end
  #    redirect_to root_path
  #  end

  def transmit
    message = Message.find(params[:id])
    recipients = message.program.recipients
    recipients.each do |recipient|
      send_message(message, recipient)
    end
    flash[:success] = "The message '#{message.title}' has been successfully sent to #{recipients.count} recipients"
    redirect_to program_path(message.program.id)
  end

  private

  def send_message(message, recipient)
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => recipient.number,
      :body => message.title
    )
  end
end

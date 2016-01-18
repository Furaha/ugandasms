class MessagesController < ApplicationController
  require 'twilio-ruby' 
  def send_questions   
     
    
    @campaign = Campaign.find(params[:campaign_id])
    @question_one = @campaign.questions.first
    @options = @question_one.options
    @option_string = ""
    @counter = 1
    @options.each do |option|
      @option_string << "\n #{@counter}. #{option.title}"
      @counter += 1
    end

    @msg = "#{@question_one.title} \n #{@option_string}"
    @participants = Participant.all
    @participants.each do |participant|
      participant.send_message(@msg)
    end
  end

  def receive_texts
    @message_body = params["Body"]
    @from_number = params["From"]
    @campaign = Campaign.create(title: @message_body)    
    render nothing: true    
  end
end

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
      participant.track_campaign(@campaign.id, 1)
    end

    redirect_to root_path
  end

  def receive_texts    
    @phone_number = params[:From]
    @participant = Participant.find_by(number: @phone_number)
    process_message(@participant)
    render nothing: true
  end

  private

  # Process incoming SMS
    def process_message(participant)
      @campaign = Campaign.find(participant.current_campaign)
      if participant.question_count < @campaign.questions.count
        @new_question_count = participant.question_count + 1
        @message = @campaign.questions[@new_question_count].title
        respond(@message)
        participant.track_campaign(@campaign.id, @new_question_count)
      else
        respond("Thank You For Participating")
        participant.track_campaign(nil, nil)
      end
    end

    # Send an SMS back to the participant
    def respond(message)
      response = Twilio::TwiML::Response.new do |r|
        r.Message message
      end
      render text: response.text
    end
end

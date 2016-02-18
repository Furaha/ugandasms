class MessagesController < ApplicationController

  require 'twilio-ruby' 

  skip_before_filter  :verify_authenticity_token

  def start_campaign
    @campaign = Campaign.find(params[:campaign_id])
    @question_one = @campaign.questions.first
    @participants = Participant.all
    @participants.each do |participant|
      if !participant.campaign_is_tracked?(@campaign.id)
        participant.send_message(@question_one.message)
        participant.track_campaign(@campaign.id, 1)
      end
    end
    redirect_to root_path
  end

  def receive_texts    
    @phone_number = params[:From]
    @body = if params[:Body].nil? then '' else params[:Body].downcase end
    if @body.blank?
      respond('Sorry No reply was received, please try again')
    else
      @participant = Participant.find_by(number: @phone_number)
      process_message(@participant, @body)
    end
    render nothing: true
  end

  private

  # Process incoming SMS
    def process_message(participant, answer)
      @campaign = participant.tracked_campaign
      @next_question = participant.next_question
      participant.save_answer(answer)
      if @next_question.nil?
        participant.send_message("Thank You For Participating")
        # respond("Thank You For Participating")
        participant.track_campaign(nil, nil)
      else
        participant.send_message(@next_question.message)
        #respond(@next_question.title)
        participant.track_campaign(@campaign.id, (participant.question_count + 1))
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

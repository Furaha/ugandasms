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
        participant.track_campaign(@campaign.id)
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
end

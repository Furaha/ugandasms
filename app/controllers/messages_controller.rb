class MessagesController < ApplicationController
  require 'twilio-ruby' 

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

  def send_question
    @campaign = Campaign.find(params[:campaign_id])
    @question = Question.find(params[:question_id])
    @participants = Participant.all
    @participants.each do |participant|
      participant.send_message(@question.message)
    end
    flash[:success] = "The Question has been Successfully sent"
    redirect_to campaign_path(@campaign)
  end
end

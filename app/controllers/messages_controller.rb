class MessagesController < ApplicationController
  require 'twilio-ruby' 
  def send_questions
    # put your own credentials here 
    account_sid = 'ACb4ac90716fe9b1dd72b9543081efd73a' 
    auth_token = 'b3fce408cee2643e807aa798c08e1da5' 
     
    # set up a client to talk to the Twilio REST API 
    @client = Twilio::REST::Client.new account_sid, auth_token
    @campaign = Campaign.find(params[:campaign_id])
    @question_one = @campaign.questions.first
    @options = @question_one.options
    @option_string = ""
    @counter = 1
    @options.each do |option|
      @option_string << "\n #{@counter}. #{option.title}"
      @counter += 1
    end    
    @client.account.messages.create({
      :from => '+16194583340', 
      :to => '+255788564570', 
      :body => "#{@question_one.title} \n #{@option_string}"
    })
    redirect_to root_path
  end

  def receive_texts
    @message_body = params["Body"]
    @from_number = params["From"]
    @campaign = Campaign.create(title: @message_body)    
    render nothing: true    
  end
end

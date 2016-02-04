class Participant < ActiveRecord::Base
  validates :number, presence: true
  has_many :answers
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

  def last_answer_entry
    return Answer.where(participant_id: self.id).order("created_at").last
  end

  def tracked_campaign
    if self.current_campaign.nil?
      return nil
    else
      return Campaign.find(self.current_campaign)
    end
  end

  def campaign_incomplete?
    @number_of_questions = self.tracked_campaign.questions.count
    if (self.question_count.nil? && (@number_of_questions >= 1)) || (!self.question_count.nil? && (self.question_count < @number_of_questions))
      true
    else
      false
    end
  end

  def next_question
    if self.campaign_incomplete?
      @last_answer_entry = self.last_answer_entry
      if @last_answer_entry.nil? #in the event of question 1
        return self.tracked_campaign.questions.order("created_at")[1]
      else
        @question_count = self.question_count
        @questions = @last_answer_entry.campaign.questions.order("created_at")
        #using question_count because arrays start counting from zero
        #and the next question  = (@question_count -1 + 1)
        return @questions[@question_count]
      end
    else
      return nil
    end
  end

  def current_question
    if self.next_question.nil?
      return self.tracked_campaign.questions.order("created_at").last.title
    else
      return self.tracked_campaign.questions.order("created_at")[self.question_count - 1].title
    end
  end

  def save_answer(answer)
    Answer.create(participant_id: self.id, campaign_id: self.tracked_campaign.id,
                  question_text: self.current_question, question_reply: answer)
  end

  def campaign_is_tracked?(campaign_record_id)
    @answer_records = Answer.where(participant_id: self.id, campaign_id: campaign_record_id)
    if (!self.tracked_campaign.nil? && (self.tracked_campaign.id == campaign_record_id)) || !@answer_records.empty?
      true
    else
      false
    end
  end
end

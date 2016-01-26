require 'test_helper'

class ParticipantAnswerTest < ActiveSupport::TestCase
  def setup
    @participant_answer = participant_answers(:one)  
  end

  test 'should be valid' do
    assert @participant_answer.valid?
  end

  test 'invalid without an option_id' do
    @participant_answer.option_id = nil
    assert_not @participant_answer.valid?
  end

  test 'invalid without a question_id' do
    @participant_answer.question_id = nil
    assert_not @participant_answer.valid?
  end

  test 'invalid without a campaign_id' do
    @participant_answer.campaign_id = nil
    assert_not @participant_answer.valid?
  end 
end

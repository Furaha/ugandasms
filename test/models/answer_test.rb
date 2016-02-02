require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    @answer = answers(:one)  
  end

  test 'should be valid' do
    assert @answer.valid?
  end

  test 'invalid without an option_id' do
    @answer.question_reply = nil
    assert_not @answer.valid?
  end

  test 'invalid without a question_id' do
    @answer.question_text = nil
    assert_not @answer.valid?
  end

  test 'invalid without a campaign_id' do
    @answer.campaign_id = nil
    assert_not @answer.valid?
  end 
end

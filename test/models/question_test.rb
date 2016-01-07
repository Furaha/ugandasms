require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @question = questions(:question_one)  
  end

  test 'should be valid' do
    assert @question.valid?
  end

  test 'invalid without a title' do
    @question.title = nil
    assert_not @question.valid?
  end

  test 'invalid without a campaign_id' do
    @question.campaign_id = nil
    assert_not @question.valid?
  end

  test 'has many options' do
    assert @question.options.count > 1
  end
end

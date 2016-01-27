require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  def setup
    @option = options(:option_one)    
  end

  test 'should be valid' do
    assert @option.valid?
  end

  test 'invalid without a title' do
    @option.title = nil
    assert_not @option.valid?
  end

  test 'invalid without a question_id' do
    @option.question_id = nil
    assert_not @option.valid?
  end

  test 'has many participant_anwsers' do
    assert @option.answers.count > 1
  end
end

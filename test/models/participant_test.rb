require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  def setup
    @participant = participants(:one)
  end

  test 'should be valid' do
    assert @participant.valid?
  end

  test 'invalid without a number' do
    @participant.number = nil
    assert_not @participant.valid?
  end
end

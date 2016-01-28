require 'test_helper'

class CampaignTest < ActiveSupport::TestCase
  def setup
    @campaign = campaigns(:malaria)
  end

  test 'should be valid' do
    assert @campaign.valid?
  end

  test 'invalid without a title' do
    @campaign.title = nil
    assert_not @campaign.valid?
  end

  test 'has many questions' do
    assert @campaign.questions.count > 1
  end

  test 'has many answers' do
    assert @campaign.answers.count > 1
  end

  test 'can have more than one unique answer per participant' do
    assert @campaign.answers.first != @campaign.answers[1]
    assert @campaign.answers.first.participant == @campaign.answers[1].participant
  end
end

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

  test 'has many participant_anwsers' do
    assert @campaign.answers.count > 1
  end
end

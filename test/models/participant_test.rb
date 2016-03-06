require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  def setup
    @participant = participants(:one)
    @campaign = campaigns(:malaria)
  end

  test 'should be valid' do
    assert @participant.valid?
  end

  test 'invalid without a number' do
    @participant.number = nil
    assert_not @participant.valid?
  end
  
  test 'track_campaign' do
    @participant.track_campaign(@campaign.id)
    assert @participant.current_campaign == @campaign.id
  end

  test 'tracked_campaign' do
    @participant.track_campaign(@campaign.id)
    assert @participant.tracked_campaign == @campaign
  end  

  test 'import' do
    skip('file does not exist')
    Participant.delete_all
    Participant.import(Rack::Test::UploadedFile.new(Rails.root.join('app', 'campaigns', 'test.csv'), 'text/csv'))
    assert Participant.count == 4
  end
end

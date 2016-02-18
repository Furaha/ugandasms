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

  test 'has many answers' do
    assert @participant.answers.count > 1
  end

  test 'track_campaign' do
    @participant.track_campaign(@campaign.id, 1)
    assert @participant.current_campaign == @campaign.id
    assert @participant.question_count == 1
  end

  test 'tracked_campaign' do
    @participant.track_campaign(@campaign.id, 1)
    assert @participant.tracked_campaign == @campaign
  end

  test 'campaign_incomplete?' do
    @participant.track_campaign(@campaign.id, 1)
    assert @participant.campaign_incomplete? == true
  end

  test 'last_answer_entry' do
    Answer.create(participant_id: @participant.id, campaign_id: @campaign.id,
      question_text: "Can Malaria Affect Animals?", question_reply: "No")
    assert @participant.last_answer_entry.question_text == "Can Malaria Affect Animals?"
  end

  test 'next_question' do
    @participant.track_campaign(@campaign.id, 1)
    assert @participant.next_question == Question.find_by(title: "do you know about proteins?")
  end

  test 'current_question' do
    @participant.track_campaign(@campaign.id,1)
    assert @participant.current_question == "what is your favourite food?"
  end

  test 'import' do
    Participant.delete_all
    Participant.import(Rack::Test::UploadedFile.new(Rails.root.join('app', 'campaigns', 'test.csv'), 'text/csv'))
    assert Participant.count == 4
  end
end

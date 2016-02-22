require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  def setup
    @campaign = campaigns(:malaria)
    @question = @campaign.questions.first
  end
  test "POST send_campaign" do
    post :start_campaign, campaign_id: @campaign.id
    assert_response 302
  end

  test "POST send_question" do
    post :send_question, campaign_id: @campaign.id, question_id: @question.id
    assert_response 302
  end
end

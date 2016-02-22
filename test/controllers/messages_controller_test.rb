require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  def setup
    @campaign = campaigns(:malaria)
  end
  # test "POST send_questions" do
  #   post :send_questions, campaign_id: @campaign.id
  #   assert_response 302
  # end
end

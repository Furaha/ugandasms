require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  def setup
    @campaign = campaigns(:malaria)
  end

  test "POST start_campaign" do
    post :start_campaign, campaign_id: @campaign.id
    assert_response 302
  end
end

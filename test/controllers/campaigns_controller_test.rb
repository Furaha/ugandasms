require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "GET new" do
  	get :new
  	assert_response :success
  end
end


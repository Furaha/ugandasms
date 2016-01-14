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

  test "POST create" do
  	post :create, :campaign => { :title => "malaria campaign", 
  		:file => Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'test.yml'), 'text/x-yaml') }
  	assert_response 302
  end
end


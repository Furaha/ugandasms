require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase
	def setup
		@participant = participants(:one)
	end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "GET new" do
  	get :new
  	assert_response :success
  end

  test "GET edit" do
  	get :edit, id: @participant.id
  	assert_response :success
  end

  test "PATCH Update" do
  	patch :update, id: @participant.id, participant: { number: '+255655719909090' }
	  assert_response :redirect
  end

  test "POST create" do
  	post :create, :file => Rack::Test::UploadedFile.new(Rails.root.join('app', 'campaigns', 'test.csv'), 'text/csv')
  	assert_response 302
  end
end

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
    patch :update, id: @participant.id, participant: { number: '+255655719909' }
    assert_equal flash[:success], "Successful Update"
    assert_response :redirect
  end

  test "PATCH Update[failure]" do
    patch :update, id: @participant.id, participant: { number: "" }
    assert_equal flash[:danger], "Number can't be blank"
    assert_response 200
  end

  test "POST create" do
    skip('file does not exist')
    post :create, :file => Rack::Test::UploadedFile.new(Rails.root.join('app', 'campaigns', 'test.csv'), 'text/csv')
    assert_equal flash[:success], "Phone Numbers imported"
    assert_response 302
  end

  test "POST create[Failure]" do
    skip('file does not exist')
    post :create, :file => Rack::Test::UploadedFile.new(Rails.root.join('app', 'campaigns', 'test.yml'), 'text/x-yaml')
    assert_equal flash[:danger], "Invalid CSV file format"
    assert_response 200
  end
end

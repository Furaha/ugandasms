require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  def setup
    @campaign = campaigns(:malaria)
  end

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
  		:file => Rack::Test::UploadedFile.new(Rails.root.join('app', 'campaigns', 'test.yml'), 'text/x-yaml') }
    assert_equal flash[:success], "The Campaign has been Successfully created"
  	assert_response 302
  end

  test "POST create[wrong file type]" do
    post :create, :campaign => { :title => "malaria campaign", 
      :file => Rack::Test::UploadedFile.new(Rails.root.join('app', 'campaigns', 'test.csv'), 'text/csv') }
    assert_equal flash[:danger], "File content type is invalid and File is invalid"
    assert_response 200
  end

  test "POST create[failure]" do
    post :create, :campaign => { :title => "" }
    assert_equal flash[:danger], "File can't be blank and Title can't be blank"
    assert_response 200
  end

  test "GET show" do
    get :show, id: @campaign.id
    assert_response :success
  end

  test "GET edit" do
    get :edit, id: @campaign.id
    assert_response :success
  end

  test "PATCH Update" do
    patch :update, id: @campaign.id, :campaign => { :title => "malaria campaign",
      :file => Rack::Test::UploadedFile.new(Rails.root.join('app', 'campaigns', 'test.yml'), 'text/x-yaml') }
      assert_equal flash[:success], "The Campaign has been Successfully updated"
    assert_response 302
  end

  test "DELETE destroy" do
    delete :destroy, id: @campaign.id
    assert_response 302
  end

  def file
    @file ||= File.open(File.expand_path( '../../file/test.yml', __FILE__))
  end

  def uploaded_file(klass, attribute, file, content_type = 'text/x-yaml')
    filename = File.basename(file.path)
    klass_label = klass.to_s.underscore
   
    ActionDispatch::Http::UploadedFile.new(
      tempfile: file,
      filename: filename,
      head: %Q{Content-Disposition: form-data; name="#{klass_label}[#{attribute}]"; filename="#{filename}"},
      content_type: content_type
    )
  end

  def uploading_file
    campaigns = Campaign.last
    assert_equal(File.basename(file.path), campaign.file_identifier)
  end
end


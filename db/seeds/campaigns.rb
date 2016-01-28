Campaign.create!([
  { title: "Malaria Campaign", file: Rack::Test::UploadedFile.new(Rails.root.join('app', 'campaigns', 'test.yml'), 'text/x-yaml')}
])
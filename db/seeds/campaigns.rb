Campaign.create!([
  { title: "Malaria Campaign", file: Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'test.yml'), 'text/x-yaml')}
])
source 'https://rubygems.org'


gem 'rails', '4.2.3' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg' # Use sqlite3 as the database for Active Record
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0' # Use CoffeeScript for .coffee assets and views
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'turbolinks' # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.
gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes

# Moar gems
gem "paperclip",  :git => "git://github.com/thoughtbot/paperclip.git"
gem 'twilio-ruby'

group :development, :test do
  gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'spring' # Spring speeds up development by keeping your application running in the background. 
  gem 'web-console',     '~> 2.0' # Access an IRB console on exception pages or by using <%= console %> in views

end

group :test do
  gem 'minitest-reporters',  '1.0.5'
  gem 'mini_backtrace',      '0.1.3'
  gem 'guard-minitest',      '2.3.1'
end

group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
end

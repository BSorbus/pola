source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.7'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'minitest-reporters'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "binding_of_caller"
  gem 'better_errors'
  gem 'brakeman', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'bootstrap-sass', '>=3.4.1'
gem 'devise', '4.6.0'
gem 'devise-security'
gem 'rails_email_validator'

# Use jquery as the JavaScript library 2017.06.19
gem 'jquery-rails'
gem 'font_awesome5_rails'
gem 'select2-rails', '3.5.9.3'
gem 'kaminari'
gem 'jquery-datatables', '= 1.10.16' #1.10.19 jakis problem z wyswietlaniem strzalek sortowania
gem 'ajax-datatables-rails', '= 0.4.0' #0.4.3 wywala się na custom_filter
gem 'pundit'
gem 'carrierwave', '~> 1.0'
gem 'file_validators'
gem 'activerecord-import'
gem 'jquery-fileupload-rails'

gem 'fullcalendar-rails'
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'

gem 'chartkick', '>= 3.2.0'
gem 'groupdate'

gem 'activerecord-postgis-adapter'
gem 'rgeo-geojson'

gem 'rack-cors', :require => 'rack/cors'
gem 'rack-attack'
gem 'mina'

gem 'inky-rb', require: 'inky'
gem 'premailer-rails'
gem 'redis-rails'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'trix'

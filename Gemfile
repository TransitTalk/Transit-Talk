source 'https://rubygems.org'
ruby '2.3.0'


git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

group :production do
	# MySQL
	gem 'mysql2', '~> 0.3.18'
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use sqlite3 as the database for Active Record

group :development, :test do
	# SQLite, only on local
	gem 'sqlite3'
end

# Use devise here for db management
gem 'devise'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'geokit-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
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
  gem 'byebug', platform: :mri
  # Static code analyser
  gem 'rubocop', '~> 0.53.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# GTFS to parse data
gem "gtfs"
gem 'pry'

# TimeDifference for nifty rake time stuff
gem "time_difference"

# Useful for big data transactions
gem "activerecord-import"

# dotenv (https://github.com/bkeepers/dotenv), which lets us store config in .env
gem 'dotenv-rails', :groups => [:development, :test]

# Add httpparty (https://github.com/jnunemaker/httparty) for simpler HTTP
gem 'httparty'

# Gem for site wide settings for site configuration
gem 'rails-settings-cached'

# UI for rails-settings
gem 'rails-settings-ui'

# For controller tests
gem 'rails-controller-testing'

# Add SimpleCov for code coverage & coveralls config
gem 'simplecov', require: false, group: :test

# Add Coveralls for code coverage badge & tracking
gem 'coveralls', require: false

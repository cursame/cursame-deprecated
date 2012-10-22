
source 'http://rubygems.org'
gem 'taps'
gem 'rails', '3.1.1'
gem 'devise', '2.0'
gem 'mime-types'
gem 'carrierwave', :require => ["carrierwave", "carrierwave/processing/mime_types"]
gem 'carrierwave_direct'
gem 'mini_magick'
gem 'fog'
gem 'kaminari'
gem 'jquery-rails'
gem 'formtastic',  "~> 2.0.2"
gem 'haml'
gem 'sanitize'
gem "breadcrumbs_on_rails", "~> 2.1.0"
gem "tabs_on_rails",        "~> 2.0.2"
gem "auto_html"
gem "transitions", :require => ["transitions", "active_record/transitions"]
gem "csv_builder"
gem "fastercsv"
gem 'delayed_job_active_record'
gem 'rails-i18n'
gem "watu_table_builder", :require => "table_builder"
gem "faye"
gem 'airbrake'
gem 'innsights', :github => 'innku/innsights-gem', :branch => 'develop'
# gem 'innsights', :path => '~/Code/Web/innsights-gem/'
#detect the browser type
gem 'useragent'
gem "ransack"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier',     '>= 1.0.3'
end

group :test do
  gem "uuid"
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'launchy'
  gem 'timecop'
  gem 'selenium'
  gem 'growl-rspec'
end

group :staging, :production do
  gem 'thin' 
  gem "heroku"
  gem "pg"
  gem 'therubyracer'
  gem 'airbrake'
  gem 'foreman'
end

group :development, :test do 
  # gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'ffaker'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl', '2.0.4'
  gem 'steak'
  gem 'spork', '0.9.0.rc9'
  gem 'hirb'
  gem "parallel_tests"
  gem 'foreman'
end

#Gem for exporting data between databases
gem 'yaml_db'
gem 'unicorn'

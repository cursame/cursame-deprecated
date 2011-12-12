source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'devise'
gem 'mime-types'
gem 'carrierwave', :require => ["carrierwave", "carrierwave/processing/mime_types"]
gem 'mini_magick'
gem 'fog'
gem 'kaminari'
gem 'jquery-rails'
gem 'formtastic'
gem 'haml'
gem 'sanitize'
gem "breadcrumbs_on_rails", "~> 2.1.0"
gem "tabs_on_rails", "~> 2.0.2"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'launchy'
end

group :staging, :production do
  gem 'thin'
  gem 'heroku'
  gem "pg"
  gem 'therubyracer'
end

group :development, :test do
  gem 'ffaker'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'steak'
  gem 'spork', '0.9.0.rc9'
end

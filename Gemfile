source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem "transitions", :require => ["transitions", "active_record/transitions"]
gem 'devise'
gem "cancan"
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'kaminari'
gem 'jquery-rails'
gem 'formtastic'
gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  # gem 'turn', :require => false
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'database_cleaner'
end

group :staging, :production do
  gem 'heroku'
  gem "pg"
  gem 'therubyracer-heroku'
end

group :development, :test do
  gem 'ffaker'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'steak'
  gem 'spork'
  gem 'launchy'
end

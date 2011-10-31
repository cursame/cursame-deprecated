source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'sqlite3'
gem "transitions", :require => ["transitions", "active_record/transitions"]
gem 'devise'
gem "cancan"
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'kaminari'
gem 'jquery-rails'
gem 'sass-rails'#, '>=3.1.0.rc.4'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  # gem 'turn', :require => false
  gem 'factory_girl'
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'ffaker'
end

group :staging, :production do
  gem 'heroku'
  gem "pg"
  gem 'therubyracer-heroku'
end

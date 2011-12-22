require 'rubygems'
require 'spork'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'ffaker'
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require 'shoulda/matchers/integrations/rspec'
require 'carrierwave/test/matchers'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}

Spork.prefork do
  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = false
    config.include Devise::TestHelpers, :type => :controller

    config.before :suite do
      DatabaseCleaner.clean_with :truncation
    end

    config.before :each do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.start
    end

    config.after :each do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
end

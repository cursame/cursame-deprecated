require 'rubygems'
require 'spork'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'ffaker'
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require 'shoulda/matchers/integrations/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Spork.prefork do
  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include Devise::TestHelpers, :type => :controller
    # config.before(:suite) do
    #   DatabaseCleaner.strategy = :transaction
    #   DatabaseCleaner.clean_with(:truncation)
    # end

    # config.before(:each) do
    #   DatabaseCleaner.start
    # end

    # config.after(:each) do
    #   DatabaseCleaner.clean
    # end
  end
end

Spork.each_run do
end






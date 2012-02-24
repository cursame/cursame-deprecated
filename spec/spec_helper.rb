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
require "selenium-webdriver"

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("spec/factories/*.rb")].each {|f| require f}
Dir[Rails.root.join("spec/acceptance/support/**/*.rb")].each {|f| require f}

Capybara.app_host     = "lvh.me"
Capybara.default_host = "subdomain.lvh.me"
Capybara.server_port  = 8888 + ENV['TEST_ENV_NUMBER'].to_i

Spork.prefork do
  Devise.stretches = Rails.env.test? ? 1 : 10

  Rails.logger.level = 4

  RSpec.configure do |config|
    config.formatter = 'Growl::RSpec::Formatter'
    config.mock_with :rspec
    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = false
    config.include Devise::TestHelpers, :type => :controller

    config.before :suite do
      DatabaseCleaner.clean_with :deletion
    end

    config.before do
      DatabaseCleaner.strategy = :deletion
      DatabaseCleaner.start
    end

    config.after do
      DatabaseCleaner.clean
      Capybara.use_default_driver if example.metadata[:js]
    end

    config.before :type => :acceptance do
      Capybara.current_driver = :selenium if example.metadata[:js]

      if Capybara.current_driver == :rack_test
        host! 'lvh.me'
        Capybara.app_host = "http://lvh.me"
      else
        host! "lvh.me:#{Capybara.server_port}"
      end
    end
  end
end

Spork.each_run do
end
